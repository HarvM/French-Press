import SwiftUI

struct HamburgerMenu: View {
    let width: CGFloat
    let isOpen: Bool
    let menuClose: () -> Void
    let animationTime: Double = 0.25
    
    // MARK: - Body
        var body: some View {
            ZStack {
                GeometryReader { _ in
                    EmptyView()
                }
                .background(Color.white.opacity(0.1).edgesIgnoringSafeArea(.all))
                .opacity(self.isOpen ? 1.0 : 0.0)
                .animation(.easeIn, value: animationTime)
                .onTapGesture {
                    self.menuClose()
                }
                HStack {
                    /// Places the content inside this view
                    BurgerMenuContent()
                        .frame(width: self.width)
                        .offset(x: self.isOpen ? 0 : -self.width)
                        .animation(.easeIn, value: animationTime)
                    Spacer()
                }
            }
        }
    }
//struct HamburgerMenu_Previews: PreviewProvider {
//    static var previews: some View {
////        HamburgerMenu()
//    }

