//
//  MainTabViewController.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 14/11/22.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Hello MainTabViewController")


        NotificationCenter.default.addObserver(self, selector: #selector(changeIndex(notification:)), name: Notification.Name("changeIndex"), object: nil)
        // Do any additional setup after loading the view.
        
    }
    
    
    @objc func changeIndex(notification: NSNotification) {
        let index = notification.userInfo?["index"] as! Int
        self.selectedIndex = index
    }

}
