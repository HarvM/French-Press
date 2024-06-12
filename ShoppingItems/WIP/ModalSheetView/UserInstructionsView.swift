import SwiftUI
import SDWebImageSwiftUI

struct UserInstructionsView: View {
    @State var isAnimating: Bool = true

    var body: some View {
        VStack {
            VStack(spacing: 0) {
                AnimatedImage(name: "leftDrag.gif", isAnimating: $isAnimating)
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            Text("Swipe left on an item to remove it from the list")
        }
    }
}

#Preview {
    UserInstructionsView()
}
