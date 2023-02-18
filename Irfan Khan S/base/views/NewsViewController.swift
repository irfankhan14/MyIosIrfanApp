//
//  NewsViewController.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 27/01/23.
//

import UIKit

class NewsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //    https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=819637923ff648afa45ec02f9630ce12
        fetchNewsFeed()
    }
    
    private func fetchNewsFeed() {
        if let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=819637923ff648afa45ec02f9630ce12") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let newsFeedData = try JSONDecoder().decode(NewsFeed.self, from: data)
                        print(newsFeedData.status)
                    } catch let error {
                        print("Error::", error)
                    }
                }
            }.resume()
        }
    }
    
    private func test() {
        let person = """
        {
            "name": "Josh",
            "age": 30,
            "full_name": "Josh Smith"
        }
        """
        
        print(person)
        
        let personData = Data(person.utf8)
        
        //3 - Create a JSONDecoder instance
        let jsonDecoder = JSONDecoder()
        
        //4 - set the keyDecodingStrategy to convertFromSnakeCase on the jsonDecoder instance
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        //5 - Use the jsonDecoder instance to decode the json into a Person object
        do {
            let decodedPerson = try jsonDecoder.decode(Person.self, from: personData)
            print("Person -- \(decodedPerson.name) was decode and their age is: \(decodedPerson.age)")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
