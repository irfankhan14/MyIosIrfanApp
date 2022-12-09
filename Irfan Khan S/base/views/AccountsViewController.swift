//
//  AccountsViewController.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 08/12/22.
//

import UIKit

class AccountsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableAccounts: UITableView!
    var transactionsList = Array<TransactionsData>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadTransactions()
        
        let uiNib = UINib(nibName: "AccountTableViewCell", bundle: nil)
        tableAccounts.register(uiNib, forCellReuseIdentifier: "transactions_cell")
        //        tableAccounts.contentInset = UIEdgeInsets(top: 0, left: -24, bottom: 0, right: 0)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableAccounts.dequeueReusableCell(withIdentifier: "transactions_cell", for: indexPath) as! AccountTableViewCell
        
        cell.txtAmount.text = fetchAmount(amount: String(transactionsList[indexPath.row].amount))
        cell.txtTransactionType.text = transactionsList[indexPath.row].transactionType
        cell.txtTransactionType.textColor = fetchTransactionTypeColor(transactionType: transactionsList[indexPath.row].transactionType)
        cell.txtReason.text = transactionsList[indexPath.row].reason
        cell.txtTimestamp.text = fetchTimeStamp(timeStamp: transactionsList[indexPath.row].timestamp)
        cell.imgAccountType.image = fetchImageType(accountType: transactionsList[indexPath.row].accountType)
        
        return cell
    }
    
    private func loadTransactions() {
        transactionsList.append(TransactionsData(idValue: 1, amountValue: 10.0, transactionValue: "Cash Deposit", reasonValue: "Testing", timestampValue: "202201011920", accountValue: "account_sbi"))
        transactionsList.append(TransactionsData(idValue: 2, amountValue: -20.0, transactionValue: "Cash Withdrawal", reasonValue: "Hello World", timestampValue: "202205010105", accountValue: "account_icici"))
        transactionsList.append(TransactionsData(idValue: 3, amountValue: 30.0, transactionValue: "Cash Back", reasonValue: "My Data Value Received", timestampValue: "202210111417", accountValue: "account_icici_credit"))
    }
    
    private func fetchAmount(amount: String) -> String {
        return "Rs. " + amount
    }
    
    private func fetchTransactionTypeColor(transactionType: String) -> UIColor {
        
        if (transactionType == Constants.init().TXT_CASH_DEPOSIT) {
            return UIColor.systemGreen
        } else if (transactionType == Constants.init().TXT_CASH_WITHDRAWAL) {
            return UIColor.red
        } else {
            return UIColor.black
        }
    }
    
    private func fetchTimeStamp(timeStamp: String) -> String {
        let result = Constants.init().convertDateFormat(
            fromPattern: Constants.init().plainDateFormat(),
            toPattern: Constants.init().normalDateFormat(),
            date: timeStamp)
        return result
    }
    
    private func fetchImageType(accountType: String) -> UIImage {
        if (accountType == Constants.init().TXT_ACCOUNT_SBI) {
            return UIImage(named:"ic_home_sbi")!
        } else if (accountType == Constants.init().TXT_ACCOUNT_ICICI) {
            return UIImage(named:"ic_home_icici")!
        } else if (accountType == Constants.init().TXT_ACCOUNT_ICICI_CREDIT) {
            return UIImage(named:"ic_home_credit_card")!
        } else if (accountType == Constants.init().TXT_ACCOUNT_ZERODHA) {
            return UIImage(named:"ic_home_zerodha")!
        } else if (accountType == Constants.init().TXT_ACCOUNT_FAST_TAG) {
            return UIImage(named:"ic_home_fast_tag")!
        } else if (accountType == Constants.init().TXT_ACCOUNT_PAYTM) {
            return UIImage(named:"ic_home_paytm")!
        } else if (accountType == Constants.init().TXT_ACCOUNT_PHONEPE) {
            return UIImage(named:"ic_home_phonepe")!
        } else if (accountType == Constants.init().TXT_ACCOUNT_AMAZON_PAY) {
            return UIImage(named:"ic_home_amazon_pay")!
        } else if (accountType == Constants.init().TXT_ACCOUNT_PF) {
            return UIImage(named:"ic_home_pf")!
        } else {
            return UIImage(named:"ic_home_accounts_home")!
        }
    }
    
}
