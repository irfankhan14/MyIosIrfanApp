//
//  DashBoardViewController.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 23/01/23.
//

import UIKit

class DashBoardViewController: UIViewController {

    @IBOutlet weak var txtAppname: UILabel!
    @IBOutlet weak var txtEmailAddress: UILabel!
    @IBOutlet weak var txtPhoneNumber: UILabel!
    
    @IBOutlet weak var txtDaily: UILabel!
    @IBOutlet weak var txtWeekly: UILabel!
    @IBOutlet weak var txtLowBalanceData: UILabel!
    
    @IBOutlet weak var txtDailyIncome: UILabel!
    @IBOutlet weak var txtDailyExpense: UILabel!
    @IBOutlet weak var txtWeeklyIncome: UILabel!
    @IBOutlet weak var txtWeeklyExpense: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        fetchMyAccountData()
        fetchBalanceData()
        initiliazeAccountWithCounters()
    }
    
    private func fetchMyAccountData() {
        txtAppname.text = NSLocalizedString("app_name", comment: "")
        txtEmailAddress.text = "irfan@gmail.com\nkhan@gmail.com"
        txtPhoneNumber.text = "+91 9876543210"
    }
    
    private func fetchBalanceData() {
        txtDaily.text = NSLocalizedString("txt_today", comment: "")
        txtWeekly.text = NSLocalizedString("txt_weekly", comment: "")
        txtLowBalanceData.text = NSLocalizedString("txt_balance_data", comment: "")
    }
    
    private func initiliazeAccountWithCounters() {
        
    }

    @IBAction func onExemptReasons(_ sender: Any) {
        
    }
}
