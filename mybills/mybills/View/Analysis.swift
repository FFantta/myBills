//
//  Analysis.swift
//  mybills
//
//  Created by 俊润 Chen on 2024/8/27.
//

import SwiftUI
import Charts
import SwiftData

struct Analysis: View {
//    @Query(animation: .snappy) private var sampleTransactions: [Transaction]
//    @State private var chartGroups: [ChartGroup] = []
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 10) {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//                ChartView()
//                    .frame(height: 200)
//                    .padding(10)
//                    .padding(.top, 10)
//                    .background(.background, in: .rect(cornerRadius: 10))
//                    .opacity(sampleTransactions.isEmpty ? 0 : 1)
            }
        }
    }
    
//    @ViewBuilder
//    func ChartView() -> some View {
//        /// Chart View
//        Chart {
//            ForEach(chartGroups) { group in
//                ForEach(group.categories) { chart  in
//                    BarMark(
//                        x: .value("Month", format(date: group.date, format: "MMM yy")),
//                        y: .value(chart.category.rawValue, chart.totalValue),
//                        width: 20
//                    )
//                    .position(by: .value("Category", chart.category.rawValue), axis: .horizontal)
//                    .foregroundStyle(by: .value("Category", chart.category.rawValue))
//                }
//            }
//        }
//    }
}

#Preview {
    Analysis()
}
