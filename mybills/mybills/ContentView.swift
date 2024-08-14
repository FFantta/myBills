import SwiftUI

struct ContentView: View {
    
    @State var currTab: CustomTabbar = .home
    
    var body: some View {
        
        GeometryReader { proxy in
            
            ZStack(alignment: .bottom) {
                TabView(selection: $currTab) {
                    ForEach(CustomTabbar.allCases, id: \.rawValue) { item in
                        Text(item.rawValue)
                            .tag(item)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                            .background(Color.gray)
                    }
                }
                
                CustomTabbarView(safeEdgeInsets: proxy.safeAreaInsets, currTab: $currTab)
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
