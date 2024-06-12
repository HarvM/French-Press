import SwiftUI

struct DetailView: View {
    
    // MARK: - Properties
    @Environment (\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    let itemToBeDisplayed: ShoppingItems
    let topPadding: CGFloat = 70

    // MARK: - Body of the view
    var body: some View {
        NavigationView {
            ZStack {
                Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all)
                GeometryReader { geometry in
                    VStack {
                        // MARK:  Section that displays the items name
                        Section {
                            Text ("\(itemToBeDisplayed.itemToBeAdded)")
                                .modifier(DetailItemAddedStyling())
                        } /// End of Section
                        Spacer()
                        // MARK:  Section that will hold either any extra notes or a placeholder if no extra notes exist
                        Section {
                            if itemToBeDisplayed.notesOnItem.isEmpty {
                                Image(ContentViewImages.appIcon.rawValue)
                                    .padding(.top, topPadding)
                            } else {
                                Text("\(itemToBeDisplayed.notesOnItem)")
                                    .modifier(DetailItemNotesStyling())
                            }
                        } /// End of Section
                        .padding(.bottom, geometry.size.height/2)
                    } /// End of VStack
                    .frame(width: geometry.size.width-10,
                           height: geometry.size.height,
                           alignment: .center)
                } /// End of GeometryReader
            } /// End of ZStack
            .modifier(DetailViewNavigationStyling())
        } /// End of NavigationView
    } /// End of body
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}


