//
//  NewsViewController.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 27/01/23.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableNews: UITableView!
    
    var databaseManager: DatabaseManager? = nil
    var newsArticlesList = Array<Article>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let uiNib = UINib(nibName: "NewsFeedTableViewCell", bundle: nil)
        tableNews.register(uiNib, forCellReuseIdentifier: "news_feed_cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        databaseManager = DatabaseManager.getInstance()
        fetchDummyData()
    }
    
    private func fetchDummyData() {
        let jsonData = """
                {"status":"ok","totalResults":37,"articles":[ {"source":{"id":null,"name":"Motorbiscuit.com"},"author":null,"title":"Why Dealerships Now Want Older High-Mileage Used Cars - MotorBiscuit","description":"Car dealers are doing things they wouldn't normally do to keep sales volume and profits up for what is expected to be a bad 2023.","url":"https://www.motorbiscuit.com/why-dealerships-want-older-high-mileage-used-cars/","urlToImage":null,"publishedAt":"2023-01-29T22:30:11Z","content":"The pandemic was a boon for few, but car dealers capitalized on there being fewer new vehicles, by spiking prices. It is the old supply and demand. People did less, saving them money for big purchase… [+2841 chars]"},{"source":{"id":null,"name":"KTIV"},"author":"Ervin Dohmen","title":"RAGBRAI announcement creates excitement to show off Sioux City - KTIV Siouxland's News Channel","description":"RAGBRAI returns to Sioux City for the 50th ride.","url":"https://www.ktiv.com/2023/01/29/ragbrai-announcement-creates-excitement-show-off-sioux-city/","urlToImage":"https://gray-ktiv-prod.cdn.arcpublishing.com/resizer/ZwbtjrGzqEA7CtQGGSOydLeS9GM=/1200x600/smart/filters:quality(85)/cloudfront-us-east-1.images.arcpublishing.com/gray/LSWJ32GDNZGLDCSILQBQWXODE4.jpg","publishedAt":"2023-01-29T22:12:00Z","content":"SIOUX CITY (KTIV) - The 50th RAGBRAI is back where it all started. Sioux City Mayor Bob Scott is grateful that the milestone of 50 years was recognized with the decision for Sioux City to be the hos… [+1060 chars]"}]}
                """
        
        print(jsonData)
        let newsData = Data(jsonData.utf8)
        
        do {
            let newsFeedData = try JSONDecoder().decode(NewsFeed.self, from: newsData)
            print("News Status::" , newsFeedData.status , " and total news count is::" , newsFeedData.totalResults)
            if (newsFeedData.articles.count > 0) {
                newsArticlesList.removeAll()
                newsArticlesList = newsFeedData.articles
                tableNews.reloadData()
            }
        } catch let error {
            print("Error::", error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticlesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableNews.dequeueReusableCell(withIdentifier: "news_feed_cell", for: indexPath) as! NewsFeedTableViewCell
        
        let article = newsArticlesList[indexPath.row]
        
        cell.txtNewsTitle.text = article.title
        cell.txtAuthor.text = fetchAuthorName(article: article)
        cell.txtSource.text = article.source.name
        cell.txtTimeStamp.text = fetchTimeStamp(data: article.publishedAt)
        
        if (article.urlToImage != nil) {
            let imageURL = URL(string: article.urlToImage!)
            var image: UIImage?
            if let url = imageURL {
                //All network operations has to run on different thread(not on main thread).
                DispatchQueue.global(qos: .userInitiated).async {
                    let imageData = NSData(contentsOf: url)
                    //All UI operations has to run on main thread.
                    DispatchQueue.main.async {
                        if imageData != nil {
                            image = UIImage(data: imageData as! Data)
                            cell.imgNewsArticle.image = image
                            cell.imgNewsArticle.sizeToFit()
                        } else {
                            cell.imgNewsArticle.image = UIImage(named: "ic_placeholder")
                        }
                    }
                }
            }
        } else {
            cell.imgNewsArticle.image = UIImage(named: "ic_placeholder")
        }
        
        cell.txtAuthor.layer.masksToBounds = true
        cell.txtAuthor.layer.cornerRadius = 2.0
        cell.txtAuthor.layer.backgroundColor = generateRandomColor().cgColor
        
        let newsTapMore = NewsTapGesture(target: self, action: #selector(self.onNewsMoreClicked(data: )))
        newsTapMore.artcile = article
        cell.imgMoreNews.addGestureRecognizer(newsTapMore)
        cell.imgMoreNews.isUserInteractionEnabled = true
        
        let newsTapShare = NewsTapGesture(target: self, action: #selector(self.onNewsShareClicked(data: )))
        newsTapShare.artcile = article
        cell.imgShareNews.addGestureRecognizer(newsTapShare)
        cell.imgShareNews.isUserInteractionEnabled = true
        
        return cell
    }
    
    @objc func onNewsMoreClicked(data : NewsTapGesture) {
        print("onNewsMoreClicked::", data.artcile?.title)
    }
    
    @objc func onNewsShareClicked(data : NewsTapGesture) {
        print("onNewsShareClicked::", data.artcile?.title)
    }
    
//    @objc func onNewsMoreClicked(article: Article) {
//        print("onNewsMoreClicked::", pos)
//    }
//
//    @objc func onNewsShareClicked() {
//        print("onNewsShareClicked")
//    }
    
    private func fetchNewsFeedData() {
        let selectQuery = "Select " + Constants().SET_DEFAULTS_COLUMN_DESCRIPTION + " from " + Constants().TABLE_SET_DEFAULTS + " where " + Constants().SET_DEFAULTS_COLUMN_TITLE + " = '"
        let newsDataQuery = selectQuery + Constants().NEWS_DATA + "'"
        let newsData = databaseManager!.fetchData(query: newsDataQuery)
        let newsDataArray = newsData.components(separatedBy: ",")
        
        var type = ""
        if(newsDataArray[0] == Constants().NEWS_HEADLINES) {
            type = "top-headlines?" + "country=" + newsDataArray[2]
        } else if(newsDataArray[0] == Constants().NEWS_SEARCH) {
            var searchData = newsDataArray[1]
            searchData = searchData.replacingOccurrences(of: " ", with: "")
            type = "everything?q=" + searchData
        } else {
            type = "top-headlines?category=" + newsDataArray[1]
        }
        
        let newsFeedUrl = Constants().BASE_URL + type + "&apiKey=" + newsDataArray[4]
        fetchNewsFeed(newsFeedUrl: newsFeedUrl)
    }
    
    private func fetchNewsFeed(newsFeedUrl: String) {
        if let url = URL(string: newsFeedUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let newsFeedData = try JSONDecoder().decode(NewsFeed.self, from: data)
                        print("News Status::" , newsFeedData.status , " and total news count is::" , newsFeedData.totalResults)
                        if (newsFeedData.articles.count > 0) {
                            self.newsArticlesList.removeAll()
                            self.newsArticlesList = newsFeedData.articles
                            DispatchQueue.main.async {
                                self.tableNews.reloadData()
                            }
                        }
                    } catch let error {
                        print("Error::", error)
                    }
                }
            }.resume()
        }
    }
    
    private func fetchAuthorName(article: Article) -> String {
        var author = ""
        if(article.author != nil) {
            author = article.author!
        } else {
            author = article.source.name
        }
        author = author.subStringData(str: author, start: 0, end: 1)
        return author
    }
    
    
    private func fetchTimeStamp(data: String) -> String {
        var result = ""
        result = UtilityDates().convertDateFormat(
            fromPattern: Constants().NewsDateFormat,
            toPattern: UtilityDates().plainDateFormat(),
            date: data)
        result = UtilityDates().differenceBetweenDates(
            fromDate: result,
            toDate: UtilityDates().fetchCurrentTimestamp(pattern: UtilityDates().plainDateFormat()),
            pattern: UtilityDates().plainDateFormat())
        return result
    }
    
    private func generateRandomColor() -> UIColor {
         //Generate between 0 to 1
         let red:CGFloat = CGFloat(drand48())
         let green:CGFloat = CGFloat(drand48())
         let blue:CGFloat = CGFloat(drand48())

         return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
}
                                                 
class NewsTapGesture: UITapGestureRecognizer {
    var artcile: Article? = nil
}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
