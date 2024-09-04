//
//  Deal.swift
//  mybills
//
//  Created by 俊润 Chen on 2024/8/27.
//

import SwiftUI

struct Transaction: Identifiable {
    let id: UUID = .init()
    var title: String
    var comments: String?
    var amount: Double
    var category: String
    var date: Date
    var paymentMethod: String
    
    init(title: String, comments: String? = nil, amount: Double, category: Category, date: Date, paymentMethod: String) {
        self.title = title
        self.comments = comments
        self.amount = amount
        self.category = category.rawValue
        self.date = date
        self.paymentMethod = paymentMethod
    }
}

var sampleTransactions: [Transaction] = [
    .init(title: "Magic Keyboard",
          comments: "Apple Product",
          amount: 129,
          category: .expense,
          date: Date(),
          paymentMethod: "Credit Card"),
    
    .init(title: "Apple Music",
          comments: "Subscription",
          amount: 10.99,
          category: .expense,
          date: Date(),
          paymentMethod: "Auto Pay"),
    
        .init(title: "iCloud+",
              comments: "Subscription",
              amount: 0.99,
              category: .expense,
              date: Date(),
              paymentMethod: "Auto Pay"),
        
        .init(title: "Payment",
              comments: "Payment Received!",
              amount: 2499,
              category: .income,
              date: Date(),
              paymentMethod: "Bank Transfer")
    ]
