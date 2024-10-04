//
//  DayTransactionsView.swift
//  mybills
//
//  Created by 俊润 Chen on 2024/9/4.
//

import SwiftUI

struct DayTransactionsView: View {
    var dayTransactions: [Transaction]

    var body: some View {
        VStack(alignment: .leading) {
            if let firstTransaction = dayTransactions.first {
                Text(format(date: firstTransaction.date, format: "dd MMM yyyy"))
                    .font(.title3.bold())
                    .foregroundColor(.black)
                    .padding(.leading, 10) 
                    .alignmentGuide(.leading) { _ in CGFloat(0) }
            }
            VStack(alignment: .leading) {
                ForEach(dayTransactions, id: \.id) { transaction in
                    TransactionCardView(transaction: transaction)
                }
            }
            .padding(1)
            .background()
            .cornerRadius(10)
//            .shadow(radius: 1)
        }
    }
}

struct DayTransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        DayTransactionsView(dayTransactions: [])
    }
}
