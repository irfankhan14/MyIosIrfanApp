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
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
        let dateFormat = Constants().TXT_DATE_FORMAT.replacingOccurrences(of: "-", with: "")
        let startTime = Constants().TXT_START_TIME
        let endTime = Constants().TXT_END_TIME
        
        let todayStartTime = UtilityDates().fetchCurrentTimestamp(pattern: dateFormat) + startTime
        let todayEndTime = UtilityDates().fetchCurrentTimestamp(pattern: dateFormat) + endTime
        
        let weeklyStartTime = UtilityDates().getFirstDayOfWeek(pattern: dateFormat) + startTime
        let weeklyEndTime = UtilityDates().getLastDayOfWeek(pattern: dateFormat) + endTime
        
        
        let dailyIncomeQuery = "Select sum(" + Constants().ACCOUNT_TRANSACTIONS_COLUMN_AMOUNT +
        ") from " + Constants().TABLE_ACCOUNT_TRANSACTIONS + " where " +
        Constants().ACCOUNT_TRANSACTIONS_COLUMN_TIMESTAMP + ">='" + todayStartTime + "' and " + Constants().ACCOUNT_TRANSACTIONS_COLUMN_TIMESTAMP + "<='" + todayEndTime + "' and " + Constants().ACCOUNT_TRANSACTIONS_COLUMN_TRANSACTION_TYPE + "!='" + Constants().TXT_CASH_WITHDRAWAL + "'"
        
        let dailyExpenseQuery = "Select sum(" + Constants().ACCOUNT_TRANSACTIONS_COLUMN_AMOUNT +
        ") from " + Constants().TABLE_ACCOUNT_TRANSACTIONS + " where " +
        Constants().ACCOUNT_TRANSACTIONS_COLUMN_TIMESTAMP + ">='" + todayStartTime + "' and " + Constants().ACCOUNT_TRANSACTIONS_COLUMN_TIMESTAMP + "<='" + todayEndTime + "' and " + Constants().ACCOUNT_TRANSACTIONS_COLUMN_TRANSACTION_TYPE + "='" + Constants().TXT_CASH_WITHDRAWAL + "'"
        
        let weeklyIncomeQuery = "Select sum(" + Constants().ACCOUNT_TRANSACTIONS_COLUMN_AMOUNT +
        ") from " + Constants().TABLE_ACCOUNT_TRANSACTIONS + " where " +
        Constants().ACCOUNT_TRANSACTIONS_COLUMN_TIMESTAMP + ">='" + weeklyStartTime + "' and " + Constants().ACCOUNT_TRANSACTIONS_COLUMN_TIMESTAMP + "<='" + weeklyEndTime + "' and " + Constants().ACCOUNT_TRANSACTIONS_COLUMN_TRANSACTION_TYPE + "!='" + Constants().TXT_CASH_WITHDRAWAL + "'"
        
        let weeklyExpenseQuery = "Select sum(" + Constants().ACCOUNT_TRANSACTIONS_COLUMN_AMOUNT +
        ") from " + Constants().TABLE_ACCOUNT_TRANSACTIONS + " where " +
        Constants().ACCOUNT_TRANSACTIONS_COLUMN_TIMESTAMP + ">='" + weeklyStartTime + "' and " + Constants().ACCOUNT_TRANSACTIONS_COLUMN_TIMESTAMP + "<='" + weeklyEndTime + "' and " + Constants().ACCOUNT_TRANSACTIONS_COLUMN_TRANSACTION_TYPE + "='" + Constants().TXT_CASH_WITHDRAWAL + "'"
        
        let dbInstance = DatabaseManager.getInstance()
        let dailyIncome = fetchRoundedAmountValues(amount: dbInstance.fetchData(query: dailyIncomeQuery))
        let dailyExpense = fetchRoundedAmountValues(amount: dbInstance.fetchData(query: dailyExpenseQuery))
        let weeklyIncome = fetchRoundedAmountValues(amount: dbInstance.fetchData(query: weeklyIncomeQuery))
        let weeklyExpense = fetchRoundedAmountValues(amount: dbInstance.fetchData(query: weeklyExpenseQuery))

        incrementLabel(label: txtDailyIncome, endValue: dailyIncome)
        incrementLabel(label: txtDailyExpense, endValue: dailyExpense)
        incrementLabel(label: txtWeeklyIncome, endValue: weeklyIncome)
        incrementLabel(label: txtWeeklyExpense, endValue: weeklyExpense)


    }

    @IBAction func onExemptReasons(_ sender: Any) {
        
    }
    
    private func fetchRoundedAmountValues(amount: String) -> Int {
        let abcd: Double = Double(amount) ?? 0.0
        var result = Int(abcd.rounded())
        if (result < 0) {
            result *= -1
        }
        return result
    }
    
    private func incrementLabel(label: UILabel, endValue: Int) {
        let duration: Double = 1.0 //seconds
        DispatchQueue.global().async {
            for i in 0 ..< (endValue + 1) {
                let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.async {
                    label.text = "\(i)"
                }
            }
        }
    }
}
