//
//  TransactionCardView.swift
//  mybills
//
//  Created by 俊润 Chen on 2024/9/4.
//

import SwiftUI

struct TransactionCardView: View {
    var transaction: Transaction
    var body: some View {
        HStack(spacing: 12) {
            Text("\(String(transaction.title.prefix(1)))")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
                .frame(width: 45, height: 45)
                .background(
                    Circle()
                        .fill(Color.gray)
//                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                )

            
            VStack(alignment: .leading, spacing: 4, content: {
                Text(transaction.title)
                    .foregroundStyle(Color.primary)
                
                Text(transaction.comments!)
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
    }
}

#Preview {
    TransactionCardView(transaction: sampleTransactions[0])
}
