//
//  NewsViewController.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 27/01/23.
//

import UIKit

class NewsViewController: UIViewController {
    
    
    var databaseManager: DatabaseManager? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //    https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=819637923ff648afa45ec02f9630ce12
    }
    
    override func viewDidAppear(_ animated: Bool) {
        databaseManager = DatabaseManager.getInstance()
        fetchNewsData()
    }
    
    private func fetchNewsData() {
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
        print(newsData)
        print(newsFeedUrl)
        
    }
    
    private func fetchNewsFeed(newsFeedUrl: String) {
        if let url = URL(string: newsFeedUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let newsFeedData = try JSONDecoder().decode(NewsFeed.self, from: data)
                        print("News Status::" , newsFeedData.status , " and total news count is::" , newsFeedData.totalResults)
                    } catch let error {
                        print("Error::", error)
                    }
                }
            }.resume()
        }
    }
    

    
}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
