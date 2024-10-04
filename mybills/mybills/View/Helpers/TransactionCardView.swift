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
                    .foregroundColor(.blue.opacity(0.7))
                    .frame(width: 45, height: 45)
                    .background(
                        Circle()
                            .fill(Color.pink.opacity(0.4))
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
                
                Text(currencyString(transaction.amount, allowedDigits: 2))
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
    //        .background(.background, in: .rect(cornerRadius: 10))
        } actions: {
            Action(tint: .red, icon: "trash") {
                // 在主线程上进行删除操作
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
