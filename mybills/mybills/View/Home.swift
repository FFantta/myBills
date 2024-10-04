import SwiftUI
import SwiftData

struct Home: View {
    @AppStorage("userName") private var userName: String = "Fanta"
    
    @Query(sort: [SortDescriptor(\Transaction.date, order: .reverse)]) private var transactions: [Transaction]

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            NavigationStack {
                
                ScrollView(.vertical) {
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                        Section {
                            
                            CardView(income: 4039, expense: 2389)
                            
                            ForEach(Array(groupTransactionsByDate().keys.sorted()), id: \.self) { date in
                                VStack(alignment: .leading) {
                                    Text(date) // 显示日期
                                        .font(.headline)
                                        .padding(.leading, 10)
                                    
                                     ForEach(groupTransactionsByDate()[date] ?? [], id: \.id) { transaction in
                                        NavigationLink {
                                            NewExpenseView(editTransaction: transaction)
                                        } label: {
                                            TransactionCardView(transaction: transaction)
                                        }
                                        .buttonStyle(.plain) // 去掉默认的按钮样式
                                    }
                                }
                                .padding(.bottom, 10)
                            }
                            
                        } header: {
                            HeaderView(size)
                        }
                    }
                    .padding(15)
                }
                .background(.gray.opacity(0.15))
            }
        }
    }
    
    // 按日期分组交易
    func groupTransactionsByDate() -> [String: [Transaction]] {
        return Dictionary(grouping: transactions, by: { $0.date.asSimpleDate() })
    }

    // Header View
    @ViewBuilder
    func HeaderView(_ size: CGSize) -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 5, content: {
                Text("Welcome!")
                    .font(.title.bold())
                
                if !userName.isEmpty {
                    Text(userName)
                        .font(.callout.bold())
                        .foregroundStyle(.gray)
                }
                
            })
            
            // 下拉动画
            .visualEffect { content, geometryProxy in
                content
                    .scaleEffect(headerScale(size, proxy: geometryProxy), anchor: .topLeading)
            }
            
            Spacer(minLength: 0)
            
            NavigationLink {
                NewExpenseView()
            } label: {
                Image("Plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
        }
        .padding(.bottom, userName.isEmpty ? 10 : 5)
        .background {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                
                Divider()
            }
            .visualEffect { content, geometryProxy in
                content
                    .opacity(headerBGOpacity(geometryProxy))
            }
            .padding(.horizontal, -15)
            .padding(.top, -(safeArea.top + 15))
        }
    }

    func headerBGOpacity(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY + safeArea.top
        return minY > 0 ? 0 : (-minY / 15)
    }

    func headerScale(_ size: CGSize, proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY
        let screenHeight = size.height
        let progress = minY / screenHeight
        let scale = (min(max(progress, 0), 1)) * 0.5
        return 1 + scale
    }
}

#Preview {
    ContentView()
}
