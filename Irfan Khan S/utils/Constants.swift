//
//  Constants.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 12/11/22.
//

import Foundation

class Constants {
    let emailAddress = "ik"
    let password = "ik"
    
    let keyEmailAddress = "KEY_EMAIL_ADDRESS"
    let keyAppLoginStatus = "KEY_APP_LOGIN_STATUS"
    
    
    // Date & Time Data
    let TXT_DATE_FORMAT = "yyyy-MM-dd"
    let TXT_TIME_FORMAT = "HH:mm"
    let TXT_START_TIME = "0000"
    let TXT_END_TIME = "2359"
    let TXT_START_MONTH_DATE = "01"
    let TXT_END_MONTH = "12"
    let TXT_END_DATE = "31"
    
    // Amount Transactions Type
    let TXT_CASH_DEPOSIT = "Cash Deposit"
    let TXT_CASH_WITHDRAWAL = "Cash Withdrawal"
    let TXT_CASH_BACK = "Cash Back"
    
    
    // Table Account Transactions Data
    let TABLE_ACCOUNT_TRANSACTIONS = "accounts"
    let ACCOUNT_TRANSACTIONS_COLUMN_ID = "id"
    let ACCOUNT_TRANSACTIONS_COLUMN_AMOUNT = "amount"
    let ACCOUNT_TRANSACTIONS_COLUMN_TRANSACTION_TYPE = "transaction_type"
    let ACCOUNT_TRANSACTIONS_COLUMN_ACCOUNT_TYPE = "account_type"
    let ACCOUNT_TRANSACTIONS_COLUMN_REASON = "reason"
    let ACCOUNT_TRANSACTIONS_COLUMN_TIMESTAMP = "timestamp"
    
    
    // Account Types
    let TXT_ACCOUNT_SBI = "account_sbi"
    let TXT_ACCOUNT_ICICI = "account_icici"
    let TXT_ACCOUNT_ICICI_CREDIT = "account_icici_credit"
    let TXT_ACCOUNT_ZERODHA = "account_zerodha"
    let TXT_ACCOUNT_PF = "account_pf"

    let TXT_ACCOUNT_PAYTM = "account_paytm"
    let TXT_ACCOUNT_PHONEPE = "account_phonepe"
    let TXT_ACCOUNT_AMAZON_PAY = "account_amazon_pay"
    let TXT_ACCOUNT_FAST_TAG = "account_fasttag"
    let TXT_ACCOUNT_HOME = "account_home"

    
    func normalDateFormat() -> String {
        return TXT_DATE_FORMAT + " " + TXT_TIME_FORMAT
    }
    
    func plainDateFormat() -> String {
        return TXT_DATE_FORMAT.replacingOccurrences(of: "-", with: "") + TXT_TIME_FORMAT.replacingOccurrences(of: ":", with: "")
    }
    
    func convertDateFormat(fromPattern: String, toPattern: String, date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromPattern
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = toPattern
        return dateFormatter.string(from: date!)
    }
}
