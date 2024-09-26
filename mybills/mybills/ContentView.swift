import SwiftUI

struct ContentView: View {
    
    @State var currTab: CustomTabbar = .home
    @State private var showNewExpenseView = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                
                ZStack(alignment: .bottom) {
                    TabView(selection: $currTab) {
                        // Replace the Text views with your actual views
                        Home() // Home page
                            .tag(CustomTabbar.home)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.white)
                        
                        Analysis() // Analysis page
                            .tag(CustomTabbar.analysis)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.white)
                    }
                    
                    
                    CustomTabbarView(safeEdgeInsets: proxy.safeAreaInsets, currTab: $currTab, plusAction: {
                            showNewExpenseView = true
                    })
                }
                .ignoresSafeArea(.all, edges: .bottom)
                .navigationDestination(isPresented: $showNewExpenseView) {
                    TransactionView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
