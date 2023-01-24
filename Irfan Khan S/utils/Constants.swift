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

    let MyAppData = "IrfanKhan"
    let CONST_EMAIL = "EMAIL"
    let CONST_APP_STATUS = "APP_STATUS"
    let CONST_URL = "web_url"
    let ExemptReason = "ExemptReason"
    let MusicPlayerPackageName = "media.music.musicplayer"
    let NewsDateFormat = "yyyy-MM-dd'T'HH:mm:SSS"

    let TXT_DATE_FORMAT = "yyyy-MM-dd"
    let TXT_TIME_FORMAT = "HH:mm"
    let TXT_START_TIME = "0000"
    let TXT_END_TIME = "2359"
    let TXT_START_MONTH_DATE = "01"
    let TXT_END_MONTH = "12"
    let TXT_END_DATE = "31"

    // Defaults & Personal
    let SET_DEFAULTS_TYPE_DEFAULTS = "defaults"
    let SET_DEFAULTS_TYPE_PERSONAL = "personal"


    // Share Trading Types
    let SHARES_TRADING_INTRADAY = "Intraday"
    let SHARES_TRADING_CNC = "CNC"
    let SHARES_TRADING_OTHERS = "Others"


    // Build Variants
    let BUILD_VARIANT_FLAVOUR = "BuildVariantFlavour"
    let BUILD_VARIANT_PRODUCTION = "production"
    let BUILD_VARIANT_DEVELOPMENT = "development"
    let BUILD_VARIANT_STAGING = "staging"



    // Database Type
    let DATABASE_SQLITE = "Sqlite"
    let DATABASE_ROOM = "Room"



    // Database Table Account Transaction
    let TABLE_ACCOUNT_TRANSACTIONS = "account_transactions"
    let ACCOUNT_TRANSACTIONS_COLUMN_ID = "id"
    let ACCOUNT_TRANSACTIONS_COLUMN_AMOUNT = "amount"
    let ACCOUNT_TRANSACTIONS_COLUMN_TRANSACTION_TYPE = "transaction_type"
    let ACCOUNT_TRANSACTIONS_COLUMN_REASON = "reason"
    let ACCOUNT_TRANSACTIONS_COLUMN_TIMESTAMP = "timestamp"
    let ACCOUNT_TRANSACTIONS_COLUMN_ACCOUNT_TYPE = "account_type"

    // Database Table Shares Trading
    let TABLE_SHARES_TRADING = "shares_trading"
    let SHARES_TRADING_COLUMN_ID = "id"
    let SHARES_TRADING_COLUMN_ACCOUNT_TRANSACTION_ID = "transaction_id"
    let SHARES_TRADING_COLUMN_NAME = "name"
    let SHARES_TRADING_COLUMN_TRADE_TYPE = "trade_type"
    let SHARES_TRADING_COLUMN_PRICE = "price"
    let SHARES_TRADING_COLUMN_QUANTITY = "quantity"
    let SHARES_TRADING_COLUMN_TRADE_RETURNS = "returns"

    // Database Table Interview Topics
    let TABLE_INTERVIEW_TOPICS = "interview_topics"
    let INTERVIEW_TOPICS_COLUMN_ID = "id"
    let INTERVIEW_TOPICS_COLUMN_TOPIC = "topic"
    let INTERVIEW_TOPICS_COLUMN_TOPIC_PATH = "topic_path"

    // Database Table Interview Question & Answer
    let TABLE_INTERVIEW_QA = "interview_qa"
    let INTERVIEW_QA_COLUMN_ID = "id"
    let INTERVIEW_QA_COLUMN_TOPIC = "topic"
    let INTERVIEW_QA_COLUMN_QUESTION = "question"
    let INTERVIEW_QA_COLUMN_ANSWER = "answer"
    let INTERVIEW_QA_COLUMN_TYPE = "type"
    let INTERVIEW_QA_COLUMN_ANSWER_PATH = "answer_path"

    // Database Table Personal & Defaults
    let TABLE_SET_DEFAULTS = "set_defaults"
    let SET_DEFAULTS_COLUMN_ID = "id"
    let SET_DEFAULTS_COLUMN_TYPE = "type"
    let SET_DEFAULTS_COLUMN_TITLE = "title"
    let SET_DEFAULTS_COLUMN_DESCRIPTION = "description"

    // Database Table Contacts
    let TABLE_CONTACTS = "contacts"
    let CONTACTS_COLUMN_ID = "id"
    let CONTACTS_COLUMN_NAME = "name"
    let CONTACTS_COLUMN_PHONE_NUMBER = "phone_number"
    let CONTACTS_COLUMN_CONTACT_AVAILABLE = "contact_available"

    // Database Table Workouts
    let TABLE_WORKOUTS = "workouts"
    let WORKOUTS_COLUMN_ID = "id"
    let WORKOUTS_COLUMN_NAME = "name"
    let WORKOUTS_COLUMN_IMAGE = "image"
    let WORKOUTS_COLUMN_SETS = "sets"
    let WORKOUTS_COLUMN_DAY_COUNT = "day_count"


    // Links usages in App
    let BASE_URL = "http://newsapi.org/v2/"
    let FACEBOOK_URL = "https://www.facebook.com"
    let LINKED_IN_URL = "https://www.linkedin.com"
    let TWITTER_URL = "https://www.twitter.com"
    let GMAIL_URL = "https://www.gmail.com"
    let GOOGLE_URL = "https://www.google.com"
    let QUORA_URL = "https://www.quora.com"


    // News Data
    let NEWS_HEADLINES = "getTopHeadlines"
    let NEWS_SEARCH = "getBySearch"
    let NEWS_CATEGORY = "getByCategory"
    let NEWS_DATA = "NewsData"
    let NEWS_KEY_HEADLINES = "Top Headlines"
    let NEWS_KEY_SEARCH = "Search"


    // All App Related
    let ACCOUNTS_TYPE = "accounts_type"
    let ACCOUNTS_MY_SALARY = "My Salary"
    let PF_EMPLOYEE_AMOUNT = "Employee PF Amount"
    let PF_EMPLOYER_AMOUNT = "Employer PF Amount"
    let CONTACTS_MY_NUMBER = "My Number"
    let TXT_MIN_BALANCE_DATA = "MinBalanceData"
    let TXT_HOME_EXPENSES = "Home Expenses"
    let TXT_STOCK_SOLD = "Stock Sold"
    let BKP_RST_DELIMETER = "(IKS)"
    let BACKUP_DATA = "BACKUP_DATA"
    let TXT_ENABLE_AUTO_START = "ENABLE_AUTO_START"
    let APP_SHORTCUTS = "APP_SHORTCUTS"
    let TXT_ALL = "All"
    let FTP_LET_KEY = "miaFtplet"
    let TXT_ASC = "Asc"
    let TXT_DESC = "Desc"
    let TXT_IS_AUTHENTICATED = "IsAuthenticated"
    let TXT_PAYMENT_REMINDERS = "PAYMENT_REMINDERS"

    let FTP_PORT_NUMBER = 2121
    let COUNT_DOWN_TIMER_DATA = 60
    let PICKFILE_RESULT_CODE = 1000
    let SPLASH_SCREEN_TIMEOUT = 1000
    let SELECT_FILE_FOR_QR_CODE = 1001
    let SELECT_FILE_FOR_OCR_CODE = 1002
    let MY_PERMISSIONS_REQUEST_PACKAGE_USAGE_STATS = 1003

    // All Bank Related
    let SBI = "sbi"
    let ICICI = "icici"
    let ICICI_CREDIT = "icici_credit"
    let FASTTAG = "fasttag"
    let PF = "pf"
    let ZERODHA = "zerodha"
    let PAYTM = "paytm"
    let AMAZON_PAY = "amazon_pay"
    let PHONEPE = "phonepe"

    let ACCOUNTS_SBI = "account_sbi"
    let ACCOUNTS_ICICI = "account_icici"
    let ACCOUNTS_ICICI_CREDIT = "account_icici_credit"
    let ACCOUNTS_ZERODHA = "account_zerodha"
    let ACCOUNTS_PAYTM = "account_paytm"
    let ACCOUNTS_AMAZON_PAY = "account_amazon_pay"
    let ACCOUNTS_PHONEPE = "account_phonepe"
    let ACCOUNTS_PF = "account_pf"
    let ACCOUNTS_FASTTAG = "account_fasttag"
    let ACCOUNTS_HOME = "account_home"

    let TXT_SBI = "sbi"
    let TXT_SBM = "sbm"
    let TXT_ICICI = "icici"
    let TXT_CREDIT_CARD = "credit card"
    let TXT_FASTAG = "fastag"

    let TXT_CREDITED = "credited"
    let TXT_CREDIT = "credit"
    let TXT_CASHBACK = "cashback"
    let TXT_WITHDRAW = "withdraw"
    let TXT_PURCHASE = "purchase"
    let TXT_RECEIVED = "received"
    let TXT_DEBITED = "debited"
    let TXT_DEBIT = "debit"
    let TXT_ADDED = "added"
    let TXT_CHARGES = "charges"

    let TXT_CASH_DEPOSIT = "Cash Deposit"
    let TXT_CASH_WITHDRAWAL = "Cash Withdrawal"
    let TXT_CASH_BACK = "Cash Back"
    
}
