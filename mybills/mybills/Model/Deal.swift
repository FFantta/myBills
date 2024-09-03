//
//  Deal.swift
//  mybills
//
//  Created by 俊润 Chen on 2024/8/27.
//

import SwiftUI

struct Deal: Identifiable {
    let id: UUID = .init()
    var title: String
    var comments: String?
    var amount: Double
    var category: String
    var date: Date
//    var type: String // "income" or "expense"
    var paymentMethod: String
    
    init(title: String, comments: String? = nil, amount: Double, category: Category, date: Date, paymentMethod: String) {
        self.title = title
        self.comments = comments
        self.amount = amount
        self.category = category.rawValue
        self.date = date
//        self.type = type
        self.paymentMethod = paymentMethod
    }
}
