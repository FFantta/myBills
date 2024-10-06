//
//  ReceiptItem.swift
//  mybills
//
//  Created by 俊润 Chen on 2024/10/1.
//

import SwiftData
import SwiftUI

@Model
class ReceiptItem: Identifiable {
    var id = UUID()
    var itemDescription: String
    var amount: String
    
    init(itemDescription: String, amount: String) {
        self.itemDescription = itemDescription
        self.amount = amount
    }
}
