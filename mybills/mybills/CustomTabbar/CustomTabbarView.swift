import SwiftUI

enum CustomTabbar: String, CaseIterable {
    
    case home           = "Home"
    case analysis       = "Analysis"
    
    var iconName: String {
        
        switch self {
        case .home:
            return "house.fill"
        case .analysis:
            return "chart.bar.fill"
        }
    }
    
    var norIconName: String {
        return iconName
    }
    
    var selIconName: String {
        return iconName
    }
}

struct CustomTabbarView: View {
    
    var safeEdgeInsets: EdgeInsets
    
    @Binding var currTab: CustomTabbar
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            ForEach(CustomTabbar.allCases, id: \.rawValue) { item in
                
                Button {
                    currTab = item
                } label: {
                    VStack {
                        Image(systemName: item.norIconName)
                        Text(item.rawValue)
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(Color.black.opacity(currTab == item ? 0.7 : 0.3))
                    }
                }
                .frame(maxWidth: .infinity)
                
                if item == .home {
                    Button {
                        
                    } label: {
                        Image("tabbar_post_idle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 75, height: 75)
                    }
                    .offset(y: -10)
                }
            }
        }
        .padding(.top, 20)
//        .padding(.bottom, safeEdgeInsets.bottom == 0 ? 10 : safeEdgeInsets.bottom)
//        .padding(.bottom, 10)
        
//        .background(Color.green)
        .background(
            Canvas { context, size in
                
                let width = size.width
                let heigh = size.height
                let midWidth = width * 0.5
                
                context.fill(Path { path in
                    
                    
                    path.move(to: CGPoint(x: 0, y: 20))
                    
                    path.addLine(to: CGPoint(x: midWidth - 55, y: 20))
                    
                    path.addCurve(to: CGPoint(x: midWidth, y: 0), control1: CGPoint(x: midWidth - 35, y: 20), control2: CGPoint(x: midWidth - 25, y: 0))
                    path.addCurve(to: CGPoint(x: midWidth + 55, y: 20), control1: CGPoint(x: midWidth + 25, y: 0), control2: CGPoint(x: midWidth + 35, y: 20))
                    
                    path.addLine(to: CGPoint(x: size.width, y: 20))
                    path.addLine(to: CGPoint(x: size.width, y: size.height))
                    path.addLine(to: CGPoint(x: 0, y: size.height))
                    
                }, with: .color(.white))
            }
        )
    }
}

struct CustomTabbarView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
