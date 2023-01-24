//
//  AccountsViewController.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 08/12/22.
//

import UIKit

class AccountsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TransactionsHandler {
    
    @IBOutlet weak var txtTotalAmount: UILabel!
    @IBOutlet weak var tableAccounts: UITableView!
    @IBOutlet weak var imgAddTransaction: UIImageView!
    
    var transactionsList = Array<TransactionsData>()
    
    var accountType: String = ""
    
    override func viewDidAppear(_ animated: Bool) {
        reloadData()
        if(accountType == "") {
            imgAddTransaction.isHidden = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        accountType = ""
        imgAddTransaction.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        let uiNib = UINib(nibName: "AccountTableViewCell", bundle: nil)
        tableAccounts.register(uiNib, forCellReuseIdentifier: "transactions_cell")
        //        tableAccounts.contentInset = UIEdgeInsets(top: 0, left: -24, bottom: 0, right: 0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(addTransaction))
        imgAddTransaction.addGestureRecognizer(tap)
        imgAddTransaction.isUserInteractionEnabled = true
        
        let screenSize: CGRect = UIScreen.main.bounds
        let addIconSize = 48
        imgAddTransaction.frame = CGRect(
            x: Int(screenSize.width) - (addIconSize * Int(1.5)),
            y: Int(screenSize.height) - (addIconSize * 3),
            width: addIconSize,
            height: addIconSize)
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
        
        if(accountType != "") {
            cell.imgAccountType.isHidden = true
        } else {
            cell.imgAccountType.isHidden = false
        }
        
        return cell
    }
    
    private func loadTransactions() {
        transactionsList.removeAll()
        
        let dbInstance = DatabaseManager.getInstance()
        
        dbInstance.database?.open()
        do {
            var stmt = ""
            if (accountType != "") {
                stmt = " where " +  Constants.init().ACCOUNT_TRANSACTIONS_COLUMN_ACCOUNT_TYPE + "='" + accountType + "'"
            }
            let selectQuery = "Select * from " + Constants.init().TABLE_ACCOUNT_TRANSACTIONS + stmt
            let transactionsResult = try dbInstance.database?.executeQuery(selectQuery, values: [Any]())
            while transactionsResult?.next() == true {
                
                let idValue = transactionsResult?.string(forColumn: Constants.init().ACCOUNT_TRANSACTIONS_COLUMN_ID)
                let amountValue = transactionsResult?.string(forColumn: Constants.init().ACCOUNT_TRANSACTIONS_COLUMN_AMOUNT)
                
                let id: Int = Int(idValue!) ?? 0
                let amount: Double = Double(amountValue!) ?? 0.0
                
                let transactionType = transactionsResult?.string(forColumn: Constants.init().ACCOUNT_TRANSACTIONS_COLUMN_TRANSACTION_TYPE)
                let reason = transactionsResult?.string(forColumn: Constants.init().ACCOUNT_TRANSACTIONS_COLUMN_REASON)
                let timestamp = transactionsResult?.string(forColumn: Constants.init().ACCOUNT_TRANSACTIONS_COLUMN_TIMESTAMP)
                let accountType = transactionsResult?.string(forColumn: Constants.init().ACCOUNT_TRANSACTIONS_COLUMN_ACCOUNT_TYPE)
                
                
                transactionsList.append(
                    TransactionsData(
                        idValue: id,
                        amountValue: amount,
                        transactionValue: transactionType!,
                        reasonValue: reason!,
                        timestampValue: timestamp!,
                        accountValue: accountType!
                    )
                )
                
            }
        }
        catch {
            print(error.localizedDescription)
        }
        dbInstance.database?.close()
    }
    
    private func fetchTotalAmount() {
        var stmt = ""
        if (accountType != "") {
            stmt = " where " +  Constants.init().ACCOUNT_TRANSACTIONS_COLUMN_ACCOUNT_TYPE + "='" + accountType + "'"
        }
        let selectQuery = "Select sum(" + Constants.init().ACCOUNT_TRANSACTIONS_COLUMN_AMOUNT + ") from " + Constants.init().TABLE_ACCOUNT_TRANSACTIONS + stmt
        let totalAmount = DatabaseManager.getInstance().fetchData(query: selectQuery)
        txtTotalAmount.text = NSLocalizedString("txt_ind_rupee_symbol", comment: "") + String(fetchTotalAmount(amount: totalAmount))
    }
    
    private func fetchTotalAmount(amount: String) -> Double {
        let  result = Double(amount) ?? 0.0
        return result
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
        if (accountType == Constants.init().ACCOUNTS_SBI) {
            return UIImage(named:"ic_home_sbi")!
        } else if (accountType == Constants.init().ACCOUNTS_ICICI) {
            return UIImage(named:"ic_home_icici")!
        } else if (accountType == Constants.init().ACCOUNTS_ICICI_CREDIT) {
            return UIImage(named:"ic_home_credit_card")!
        } else if (accountType == Constants.init().ACCOUNTS_ZERODHA) {
            return UIImage(named:"ic_home_zerodha")!
        } else if (accountType == Constants.init().ACCOUNTS_FASTTAG) {
            return UIImage(named:"ic_home_fast_tag")!
        } else if (accountType == Constants.init().ACCOUNTS_PAYTM) {
            return UIImage(named:"ic_home_paytm")!
        } else if (accountType == Constants.init().ACCOUNTS_PHONEPE) {
            return UIImage(named:"ic_home_phonepe")!
        } else if (accountType == Constants.init().ACCOUNTS_AMAZON_PAY) {
            return UIImage(named:"ic_home_amazon_pay")!
        } else if (accountType == Constants.init().ACCOUNTS_PF) {
            return UIImage(named:"ic_home_pf")!
        } else {
            return UIImage(named:"ic_home_accounts_home")!
        }
    }
    
    @objc func addTransaction() {
        print("Tapped on Add Transaction")
        TransactionViewController.showPopup(parentVC: self)
    }
    
    func addTrasaction(transactionData: TransactionsData, addHome: Bool) {
        let main = "INSERT INTO " + Constants.init().TABLE_ACCOUNT_TRANSACTIONS + " ("
        + Constants.init().ACCOUNT_TRANSACTIONS_COLUMN_AMOUNT + ", "
        + Constants.init().ACCOUNT_TRANSACTIONS_COLUMN_TRANSACTION_TYPE + ", "
        + Constants.init().ACCOUNT_TRANSACTIONS_COLUMN_REASON + ", "
        + Constants.init().ACCOUNT_TRANSACTIONS_COLUMN_TIMESTAMP + ", "
        + Constants.init().ACCOUNT_TRANSACTIONS_COLUMN_ACCOUNT_TYPE + ") values ('"
        + String(transactionData.amount) + "','"
        + transactionData.transactionType + "','"
        + transactionData.reason + "','"
        + transactionData.timestamp + "','"
        
        let query = main + accountType + "')"
        DatabaseManager.getInstance().handleInsertDeleteUpdate(query: query)
        
        if(addHome) {
            let queryHome = main + Constants.init().ACCOUNTS_HOME + "')"
            DatabaseManager.getInstance().handleInsertDeleteUpdate(query: queryHome)
        }
        
        reloadData()
        
    }
    
    private func reloadData() {
        loadTransactions()
        fetchTotalAmount()
        tableAccounts.reloadData()
    }
}
