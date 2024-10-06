import SwiftUI
import Charts
import SwiftData

struct Analysis: View {
    var body: some View {
        Text("Hello, World!")
    }
//    @Query(animation: .snappy) private var sampleTransactions: [Transaction]
//    @State private var chartGroups: [ChartGroup] = []
//    
//    var body: some View {
//        NavigationStack {
//            ScrollView(.vertical) {
//                LazyVStack(spacing: 10) {
//                    // 图表显示
//                    ChartView()
//                        .frame(height: 200)
//                        .padding(10)
//                        .padding(.top, 10)
//                        .background(.background, in: .rect(cornerRadius: 10))
//                        .opacity(sampleTransactions.isEmpty ? 0 : 1)
//                    
//                    // 每月收入/支出显示
//                    ForEach(chartGroups) { group in
//                        VStack(alignment: .leading, spacing: 10) {
//                            Text(format(date: group.date, format: "MMM yy"))
//                                .font(.caption)
//                                .foregroundStyle(.gray)
//                                .hSpacing(.leading)
//                            
//                            NavigationLink {
////                                ListOfExpenses(month: group.date)
//                            } label: {
//                                CardView(income: group.totalIncome, expense: group.totalExpense)
//                            }
//                            .buttonStyle(.plain)
//                        }
//                    }
//                }
//                .padding(15)
//            }
//            .navigationTitle("Analysis")
//            .background(.gray.opacity(0.15))
//            .onAppear {
//                // 创建数据组
//                createChartGroup()
//            }
//            .overlay {
//                if sampleTransactions.isEmpty {
//                    ContentUnavailableView("No Transactions Found", systemImage: "xmark.seal")
//                }
//            }
//        }
//    }
//    
//    // 图表显示
//    @ViewBuilder
//    func ChartView() -> some View {
//        Chart {
//            ForEach(chartGroups) { group in
//                ForEach(group.categories) { chart in
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
//        .chartScrollableAxes(.horizontal)
//        .chartXVisibleDomain(length: 4)
//        .chartLegend(position: .bottom, alignment: .trailing)
//        .chartYAxis {
//            AxisMarks(position: .leading) { value in
//                let doubleValue = value.as(Double.self) ?? 0
//                
//                AxisGridLine()
//                AxisTick()
//                AxisValueLabel {
//                    Text(axisLabel(doubleValue))
//                }
//            }
//        }
//        .chartForegroundStyleScale(range: [Color.green.gradient, Color.red.gradient])
//    }
//    
//    // 创建图表组数据
//    func createChartGroup() {
//        Task.detached(priority: .high) {
//            let calendar = Calendar.current
//            
//            let groupedByDate = Dictionary(grouping: sampleTransactions) { transaction in
//                let components = calendar.dateComponents([.month, .year], from: transaction.date)
//                
//                return components
//            }
//            
//            let sortedGroups = groupedByDate.sorted {
//                let date1 = calendar.date(from: $0.key) ?? .init()
//                let date2 = calendar.date(from: $1.key) ?? .init()
//                
//                return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedDescending
//            }
//            
////            let chartGroups = sortedGroups.compactMap { dict -> ChartGroup? in
////                let date = calendar.date(from: dict.key) ?? .init()
////                let income = dict.value.filter { $0.category == Category.income.rawValue }
////                let expense = dict.value.filter { $0.category == Category.expense.rawValue }
////                
////                let incomeTotalValue = total(income, category: .income)
////                let expenseTotalValue = total(expense, category: .expense)
////                
////                return ChartGroup(
////                    date: date,
////                    categories: [
////                        ChartCategory(totalValue: incomeTotalValue, category: .income),
////                        ChartCategory(totalValue: expenseTotalValue, category: .expense)
////                    ],
////                    totalIncome: incomeTotalValue,
////                    totalExpense: expenseTotalValue
////                )
////            }
//            
//            await MainActor.run {
//                self.chartGroups = chartGroups
//            }
//        }
//    }
//    
//    // 显示轴标签
//    func axisLabel(_ value: Double) -> String {
//        let intValue = Int(value)
//        let kValue = intValue / 1000
//        return intValue < 1000 ? "\(intValue)" : "\(kValue)K"
//    }
}

#Preview {
    Analysis()
}
