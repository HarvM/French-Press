import SwiftUI
import Foundation
import SwiftData

// This view will hold the List that displays the items that the user has input and kept in SwiftData
struct PopulatedView: View {
    @Query var shoppingItemEntries: [ShoppingItems]
    let stringStore = StringStore()
    @Environment (\.modelContext) var modelContext
    let generator = UINotificationFeedbackGenerator()

    var body: some View {
        NavigationView {
            ZStack {
                Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all)
                VStack {
                    List {
                        // MARK: - HStack: how the cells are displayed and populated
                        Section() {
                            ForEach(shoppingItemEntries, id: \.self) {
                                shoppingItem in
                                HStack {
                                    CellView(preferredMeasurement: shoppingItem.preferredMeasurement,
                                             quantitySelected: shoppingItem.quantitySelected,
                                             itemToBeAdded: shoppingItem.itemToBeAdded)
                                    NavigationLink("", destination: DetailView (itemToBeDisplayed: shoppingItem))
                                } /// End of HStack
                            }
                            .onDelete(perform: self.deleteItem)
                            .onMove(perform: moveItem)
                        } /// End of Section
                        .modifier(SectionStyling())
                    } /// End of List
                    .modifier(ListStyling())
                } /// End VStack
                .id(UUID())
                .listStyle(PlainListStyle())
                .navigationBarTitleDisplayMode(.inline)

                // MARK: - NavigationBarItem: Trailing item will let the user enter an item
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: NewEntryView()
                            .navigationTitle(stringStore.addItem)
                            .modifier(ToolbarStyling())
                        ){
                            Image(ContentViewImages.plusImage.rawValue)
                                .modifier(PlusButtonStyling())
                        }
                    }
                } /// End of toolbar
            } /// End of ZStack
        } /// End of NavigationView
        .background(Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all))
    } /// End of populatedView
}

#Preview {
    PopulatedView()
}
