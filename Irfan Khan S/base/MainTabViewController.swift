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
        navigationItem.hidesBackButton = true
        DatabaseManager.copyDatabase("irfan.db")

    }
    


}
