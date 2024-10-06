//
//  TransactionCardView.swift
//  mybills
//
//  Created by 俊润 Chen on 2024/9/4.
//

import SwiftUI

struct TransactionCardView: View {
    @Environment(\.modelContext) private var context
    var transaction: Transaction
    var body: some View {
        SwipeAction(cornerRadius: 10, direction: .trailing) {
            HStack(spacing: 12) {
                Text("\(String(transaction.title.prefix(1)))")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 45, height: 45)
                    .background(
                        Circle()
                            .fill(.purple.opacity(0.4))
    //                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    )

                
                VStack(alignment: .leading, spacing: 4, content: {
                    Text(transaction.title)
                        .foregroundStyle(Color.primary)
                    
                    Text(transaction.comments)
                        .font(.caption)
                        .foregroundStyle(Color.primary.secondary)
    //
    //                Text(format(date: transaction.date, format: "dd MMM yyyy"))
    //                    .font(.caption2)
    //                    .foregroundStyle(.gray)
                })
                .lineLimit(1)
                .hSpacing(.leading)
                
                Text("\(transaction.category == Category.expense.rawValue ? "-" : "+") \(String(format: "%.2f", transaction.amount))")
                    .fontWeight(.semibold)
                    .foregroundColor(transaction.category == Category.expense.rawValue ? .red : .green)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
    //        .background(.background, in: .rect(cornerRadius: 10))
        } actions: {
            Action(tint: .red, icon: "trash") {
                DispatchQueue.main.async {
                    context.delete(transaction)
                    
                    do {
                        try context.save()
                    } catch {
                        print("Error saving after deletion: \(error)")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
