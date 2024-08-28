import SwiftUI

struct ContentView: View {
    
    @State var currTab: CustomTabbar = .home
    
    var body: some View {
        
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
                
                
                CustomTabbarView(safeEdgeInsets: proxy.safeAreaInsets, currTab: $currTab)
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        HomeView()
        ContentView()
    }
}
