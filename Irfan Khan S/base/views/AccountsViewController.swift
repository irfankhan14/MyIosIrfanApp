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
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableAccounts.dequeueReusableCell(withIdentifier: "transactions_cell", for: indexPath) as! AccountTableViewCell
        
        let transactionData = transactionsList[indexPath.row]
        if(transactionData.transactionType == Constants.init().TXT_CASH_WITHDRAWAL) {
            transactionData.amount = -1 * transactionData.amount
        }
        
        cell.txtAmount.text = "Rs. " + String(transactionData.amount)
        cell.txtTransactionType.text = transactionData.transactionType
        cell.txtTransactionType.textColor = fetchTransactionTypeColor(transactionType: transactionData.transactionType)
        cell.txtReason.text = transactionData.reason
        cell.txtTimestamp.text = fetchTimeStamp(timeStamp: transactionData.timestamp)
        cell.imgAccountType.image = fetchImageType(accountType: transactionData.accountType)
        
        if(accountType != "") {
            cell.imgAccountType.isHidden = true
        } else {
            cell.imgAccountType.isHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (accountType != "") {
            handleTransactions(position: indexPath.row)
        }
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
        let totalAmount = DatabaseManager.getInstance().fetchDataValue(query: selectQuery)
        txtTotalAmount.text = NSLocalizedString("txt_ind_rupee_symbol", comment: "") + String(totalAmount)
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
        let result = UtilityDates().convertDateFormat(
            fromPattern: UtilityDates().plainDateFormat(),
            toPattern: UtilityDates().normalDateFormat(),
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
        TransactionViewController.showPopup(parentVC: self, data: nil)
    }
    
    func insertTransaction(transactionData: TransactionsData, addHome: Bool) {
        if(transactionData.transactionType == Constants.init().TXT_CASH_WITHDRAWAL) {
            transactionData.amount = -1 * transactionData.amount
        }
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
    
    func updateTransaction(transactionData: TransactionsData) {
        if(transactionData.transactionType == Constants.init().TXT_CASH_WITHDRAWAL) {
            transactionData.amount = -1 * transactionData.amount
        }
        let query = "Update " + Constants.init().TABLE_ACCOUNT_TRANSACTIONS + " set " +
        Constants.init().ACCOUNT_TRANSACTIONS_COLUMN_AMOUNT + " = '" + String(transactionData.amount) + "'," +
        Constants.init().ACCOUNT_TRANSACTIONS_COLUMN_TRANSACTION_TYPE + " = '" + transactionData.transactionType + "'," +
        Constants.init().ACCOUNT_TRANSACTIONS_COLUMN_REASON + " = '" + transactionData.reason + "'," +
        Constants.init().ACCOUNT_TRANSACTIONS_COLUMN_TIMESTAMP + " = '" + transactionData.timestamp + "'" +
        " where " +
        Constants.init().ACCOUNT_TRANSACTIONS_COLUMN_ID + " = '" + String(transactionData.id) + "'"

        let result = DatabaseManager.getInstance().handleInsertDeleteUpdate(query: query)
        if(result) {
            reloadData()
        }
    }
    
    private func handleTransactions(position: Int) {
        let alert = UIAlertController(
            title: NSLocalizedString("txt_transactions", comment: ""),
            message: NSLocalizedString("txt_do_update_delete", comment: ""),
            preferredStyle: UIAlertController.Style.alert)

        // add the actions (buttons)
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("txt_update", comment: ""),
            style: UIAlertAction.Style.default,
            handler: { action in
                self.updateTransaction(position: position)
            })
        )

        alert.addAction(UIAlertAction(
            title: NSLocalizedString("txt_delete", comment: ""),
            style: UIAlertAction.Style.default,
            handler: { action in
                self.deleteTransaction(position: position)
            })
        )
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("txt_cancel", comment: ""),
            style: UIAlertAction.Style.destructive, handler: { action in
                self.tableAccounts.reloadData()
            })
        )
                
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    private func deleteTransaction(position: Int) {
        let transaction = transactionsList[position]
        let query = "Delete from " + Constants.init().TABLE_ACCOUNT_TRANSACTIONS + " where " + Constants.init().ACCOUNT_TRANSACTIONS_COLUMN_ID + " = '" + String(transaction.id) + "'"
        
        let result = DatabaseManager.getInstance().handleInsertDeleteUpdate(query: query)
        if(result) {
            reloadData()
        }
    }
    
    private func updateTransaction(position: Int) {
        let transaction = transactionsList[position]
        TransactionViewController.showPopup(parentVC: self, data: transaction)
    }
    
    
    private func reloadData() {
        loadTransactions()
        fetchTotalAmount()
        tableAccounts.reloadData()
    }
}
