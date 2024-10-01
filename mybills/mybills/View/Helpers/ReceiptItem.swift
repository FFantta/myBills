//
//  ReceiptItem.swift
//  mybills
//
//  Created by 俊润 Chen on 2024/10/1.
//

import Foundation

struct ReceiptItem: Identifiable {
    var id = UUID()
    var description: String
    var amount: String
}
