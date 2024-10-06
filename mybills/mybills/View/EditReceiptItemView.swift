//
//  EditReceiptItemView.swift
//  mybills
//
//  Created by 俊润 Chen on 2024/10/6.
//

import SwiftUI

struct EditReceiptItemView: View {
    @Binding var item: ReceiptItem
    @Environment(\.dismiss) private var dismiss
    var onDelete: (() -> Void)?
    
    var body: some View {
        Form {
            Section(header: Text("Description")) {
                TextField("Item Description", text: $item.itemDescription)
            }
            Section(header: Text("Amount")) {
                TextField("Item Amount", text: $item.amount)
                    .keyboardType(.decimalPad)
            }
            Section {
                Button("Delete Item", role: .destructive) {
                    onDelete?()
                    dismiss()
                }
            }
        }
        .navigationTitle("Edit Item")
        .navigationBarItems(trailing: Button("Done") {
            dismiss()
        })
    }
}

#Preview {
    EditReceiptItemView(item: .constant(ReceiptItem(itemDescription: "Sample", amount: "0.00")))
}
