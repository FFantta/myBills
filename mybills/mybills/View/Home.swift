//
//  Home.swift
//  mybills
//
//  Created by 俊润 Chen on 2024/8/27.
//

import SwiftUI

struct Home: View {
    @AppStorage("userName") private var userName: String = "Fanta"
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            NavigationStack {
                
                ScrollView(.vertical) {
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                        Section {
                            
                            CardView(income: 4039, expense: 2389)
                            
                            ForEach(Array(groupTransactionsByDate().keys.sorted()), id: \.self) { date in
                                VStack(alignment: .leading) {
                                    DayTransactionsView(dayTransactions: groupTransactionsByDate()[date] ?? [])
                                }
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
    
    func groupTransactionsByDate() -> [String: [Transaction]] {
            Dictionary(grouping: sampleTransactions, by: { $0.date.asSimpleDate() })
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
                
            } label: {
                Image("tabbar_post_idle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
            
        }
        .padding(.bottom, userName.isEmpty ? 10 : 5)
//        .padding(10)
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
