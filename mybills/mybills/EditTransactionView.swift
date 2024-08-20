//
//  EditTransactionView.swift
//  mybills
//
//  Created by 俊润 Chen on 2024/8/20.
//

import SwiftUI
import SwiftData

struct EditTransactionView: View {
    @Bindable var transaction: Transaction
    
    var body: some View {
        TextField("Name of transaction", text: $transaction.title)
        
        Section("Amount") {
            Stepper(value: $transaction.amount, in: 0...1000, step: 1) {
               Text("Amount: \(transaction.amount, specifier: "%.2f")")
           } 
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Transaction.self, configurations: config)
        
        let transaction = Transaction(title: "Uber", amount: 17, category: "vehicle", date: Date(), type: "vehicle", paymentMethod: "wechat")
        
        return EditTransactionView(transaction: transaction)
            .modelContainer(container)
    } catch {
        return Text("failed ")
    }
    
}
 
