//
//  CardView.swift
//  mybills
//
//  Created by 俊润 Chen on 2024/8/28.
//

import SwiftUI
import Charts

struct CardView: View {
    var income: Double
    var expense: Double
    
    // 环形图
    var chartData: [ChartSegment] {
        [
            ChartSegment(category: .income, value: income),
            ChartSegment(category: .expense, value: expense)
        ]
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.background)
            
            HStack(spacing: 80) {
                
                ZStack {
                    // 环形图
                    PieChart(chartData: chartData)
                        .frame(width: 100, height: 105)
                    
                    VStack(spacing: 2) {
                        Text("\(currencyString(income - expense))")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                        
                        Image(systemName: expense > income ? "chart.line.downtrend.xyaxis" : "chart.line.uptrend.xyaxis")
                            .font(.system(size: 15))
                            .foregroundStyle(expense > income ? .red : .green)
                    }
                    .scaleEffect(0.8)
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(Category.allCases, id: \.rawValue) { category in
                        let symbolImage = category == .income ? "arrow.down" : "arrow.up"
                        let tint = category == .income ? Color.green : Color.red
                        
                        HStack(spacing: 10) {
                            Image(systemName: symbolImage)
                                .font(.callout.bold())
                                .foregroundColor(tint)
                                .frame(width: 35, height: 35)
                                .background {
                                    Circle()
                                        .fill(tint.opacity(0.25).gradient)
                                }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(category.rawValue)
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                                
                                Text(currencyString(category == .income ? income : expense, allowedDigits: 2))
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.primary)
                            }
                            
                            if category == .income {
                                Spacer(minLength: 10)
                            }
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom], 25)
            .padding(.top, 15)
        }
    }
}

struct PieChart: View {
    var chartData: [ChartSegment]

    var body: some View {
        Chart(chartData) { segment in
            SectorMark(
                angle: .value("Amount", segment.value),
                innerRadius: .ratio(0.65),
                angularInset: 1
            )
            .foregroundStyle(gradient(for: segment.category))
        }
        .chartLegend(.hidden)
    }
    
    func gradient(for category: Category) -> LinearGradient {
        switch category {
        case .income:
            return LinearGradient(gradient: Gradient(colors: [.green.opacity(0.5), .green]), startPoint: .top, endPoint: .bottom)
        case .expense:
            return LinearGradient(gradient: Gradient(colors: [.red.opacity(0.5), .red]), startPoint: .bottom, endPoint: .top)
        }
    }

}

struct ChartSegment: Identifiable {
    let id = UUID()
    let category: Category
    let value: Double
}

#Preview {
    CardView(income: 4590.2, expense: 2389)
}
