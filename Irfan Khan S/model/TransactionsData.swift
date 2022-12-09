//
//  TransactionsData.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 08/12/22.
//

import Foundation

class TransactionsData {
    
    var id: Int
    var amount: Double
    var transactionType: String
    var reason: String
    var timestamp: String
    var accountType: String
    
    init(idValue: Int, amountValue: Double, transactionValue: String, reasonValue: String, timestampValue: String, accountValue: String){
        self.id = idValue
        self.amount = amountValue
        self.transactionType = transactionValue
        self.reason = reasonValue
        self.timestamp = timestampValue
        self.accountType = accountValue
    }
    
}
