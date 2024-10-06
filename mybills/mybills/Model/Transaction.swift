//
//  Deal.swift
//  mybills
//
//  Created by 俊润 Chen on 2024/8/27.
//

import SwiftUI
import SwiftData

@Model
class Transaction {
    var title: String
    var comments: String
    var amount: Double
    var category: String
    var date: Date
    var paymentMethod: String
    var receiptItems: [ReceiptItem]
    
    init(title: String, comments: String, amount: Double, category: Category, date: Date, paymentMethod: String, receiptItems: [ReceiptItem] = []) {
        self.title = title
        self.comments = comments
        self.amount = amount
        self.category = category.rawValue
        self.date = date
        self.paymentMethod = paymentMethod
        self.receiptItems = receiptItems
    }
    
    @Transient
    var rawCategory: Category? {
        return Category.allCases.first(where: { category == $0.rawValue })
    }
}



