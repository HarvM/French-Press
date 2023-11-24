import SwiftUI
import SpriteKit

@available(iOS 17.0, *)
struct DetailView: View {
    
    // MARK: - Properties
    @Environment (\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    let itemToBeDisplayed: ShoppingItems
    @State private var hasData = false
    let foregroundColourYellow: Color = Color.yellow
    let maximumScaleFactor: Double = 0.9
    let topPadding: CGFloat = 70
    let fontSizeItemToBeDisplayed: CGFloat = 35
    let fontSizeNotes: CGFloat = 35
    let lineLimit: Int =  3
    
    // MARK: - Body of the view
    var body: some View {
        NavigationView {
            ZStack {
                Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all)
                GeometryReader { geometry in
                    VStack {
                        /// Section that displays the items name
                        Section {
                            Text ("\(itemToBeDisplayed.itemToBeAdded)")
                                .font(.custom(DefaultFont.defaultFont.rawValue,
                                              size: fontSizeItemToBeDisplayed,
                                              relativeTo: .headline))
                                .lineLimit(lineLimit)
                                .foregroundColor(foregroundColourYellow)
                        } /// End of Section
                        Spacer()
                        /// Section that will hold either any extra notes or a placeholder if no extra notes exist
                        Section {
                            if itemToBeDisplayed.notesOnItem.isEmpty {
                                Image(ContentViewImages.appIcon.rawValue)
                                    .padding(.top, topPadding)
                            } else {
                                Text("\(itemToBeDisplayed.notesOnItem)")
                                    .foregroundColor(.white)
                                    .font(.custom(DefaultFont.defaultFont.rawValue,
                                                  size: fontSizeNotes,
                                                  relativeTo: .headline))
                            }
                        } /// End of Section
                        .padding(.bottom, geometry.size.height/2)
                    } /// End of VStack
                    .frame(width: geometry.size.width-10,
                           height: geometry.size.height,
                           alignment: .center)
                } /// End of GeometryReader
            } /// End of ZStack
            .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
            .multilineTextAlignment(.center)
            .allowsTightening(true)
            .minimumScaleFactor(maximumScaleFactor)
            /// removes iPad split screen
            .navigationViewStyle(StackNavigationViewStyle())
        } /// End of NavigationView
    } /// End of body
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}