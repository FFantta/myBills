//
//  NewExpenseView.swift
//  mybills
//
//  Created by 俊润 Chen on 2024/9/11.
//

import SwiftUI

struct TransactionView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    var editTransaction: Transaction?
    
    @State private var title: String = ""
    @State private var comments: String = ""
    @State private var amount: Double = .zero
    @State private var date: Date = .now
    @State private var category: Category = .expense
    @State private var paymentMethods: String = ""
    
    @State private var receiptItems: [ReceiptItem] = []
    @State private var isScanningDescription = false
    @State private var showScannerSheet = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 15) {
                Text("Preview")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .hSpacing(.leading)
                
                // Preview Transaction Card View
                TransactionCardView(transaction: .init(
                    title: title.isEmpty ? "Title" : title,
                    comments: comments.isEmpty ? "Remarks" : comments,
                    amount: amount,
                    category: category,
                    date: date,
                    paymentMethod: paymentMethods.isEmpty ? "Other" : paymentMethods
                ))
                .background(.background, in: .rect(cornerRadius: 10))
                
                CustomSection("Title", " ", value: $title)
                CustomSection("Comments", " ", value: $comments)
                
                // Amount
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("Amount & Category")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    HStack(spacing: 15) {
                        HStack(spacing: 4) {
                            Text(currencySymbol)
                                .font(.callout.bold())
                            
                            TextField("0.0", value: $amount, formatter: numberFormatter)
                                .keyboardType(.decimalPad)
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(.background, in: .rect(cornerRadius: 10))
                        .frame(maxWidth: 130)
                        
                        CategoryCheckBox()
                    }
                })
                
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("Bill Date")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    DatePicker("Bill Date", selection: $date)
                        .labelsHidden()
                    
                    Text("Copy Receipt:")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    // Scan Receipt
                    if !receiptItems.isEmpty {
                        ForEach(receiptItems) { item in
                            HStack {
                                Text(item.itemDescription)
                                
                                Spacer()
                                
                                Text(item.amount)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    
                    HStack(spacing: 15) {
                        Button("Scan Description") {
                            isScanningDescription = true
                            showScannerSheet = true
                        }
                        .padding(.top, 10)
                        Spacer()
                        
                        Button("Scan Amount") {
                            isScanningDescription = false
                            showScannerSheet = true
                        }
                        .padding(.top, 10)
                    }
                    
                    
                })
            }
            .padding(15)
        }
        .sheet(isPresented: $showScannerSheet) {
            makeScannerView()
        }
        .navigationTitle("\(editTransaction == nil ? "Add" : "Edit") Transaction")
        .background(.gray.opacity(0.15))
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save", action: save)
            }
        })
        .onAppear(perform: {
            if let editTransaction {
                title = editTransaction.title
                comments = editTransaction.comments
                amount = editTransaction.amount
                if let category = editTransaction.rawCategory {
                    self.category = category
                }
                date = editTransaction.date
                paymentMethods = editTransaction.paymentMethod
                receiptItems = editTransaction.receiptItems
            }
        })
    }
    
    // ScannerView
    private func makeScannerView() -> ScannerView {
        ScannerView { textPerPage in
            if let scannedTexts = textPerPage {
                if isScanningDescription {
                    let newItems = scannedTexts.map { ReceiptItem(itemDescription: $0, amount: "") }
                    receiptItems.append(contentsOf: newItems)
                }
                else {
                    for (index, scannedAmount) in scannedTexts.enumerated() {
                        if index < receiptItems.count {
                            receiptItems[index].amount = scannedAmount
                        }
                    }
                }
            }
            showScannerSheet = false
        }
    }
    
    func save() {
        if let editTransaction = editTransaction {
            editTransaction.title = title
            editTransaction.comments = comments
            editTransaction.amount = amount
            editTransaction.category = category.rawValue
            editTransaction.date = date
            editTransaction.paymentMethod = paymentMethods
            editTransaction.receiptItems = receiptItems
        } else {
            let transaction = Transaction(
                title: title,
                comments: comments,
                amount: amount,
                category: category,
                date: date,
                paymentMethod: paymentMethods,
                receiptItems: receiptItems
            )
            context.insert(transaction)
        }
        
        dismiss()
    }

    @ViewBuilder
    func CustomSection(_ title: String, _ hint: String, value: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
                .hSpacing(.leading)
            
            TextField(hint, text: value)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .background(.background, in: .rect(cornerRadius: 10))
        })
    }
    
    @ViewBuilder
    func CategoryCheckBox() -> some View {
        HStack(spacing: 10) {
            ForEach(Category.allCases, id: \.rawValue) { category in
                HStack(spacing: 5) {
                    ZStack {
                        Image(systemName: "circle")
                            .font(.title3)
                            .foregroundStyle(.blue)
                        
                        if self.category == category {
                            Image(systemName: "circle.fill")
                                .font(.caption)
                                .foregroundStyle(.blue)
                        }
                    }
                    
                    Text(category.rawValue)
                        .font(.caption)
                }
                .contentShape(.rect)
                .onTapGesture {
                    self.category = category
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        .hSpacing(.leading)
        .background(.background, in: .rect(cornerRadius: 10))
    }
    
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
}

#Preview {
    NavigationStack {
        TransactionView()
    }
}
