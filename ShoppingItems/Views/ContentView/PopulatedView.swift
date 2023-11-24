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
                                    CellView(itemToBeAdded: shoppingItem.itemToBeAdded,
                                             quantitySelected: shoppingItem.quantitySelected,
                                             preferredMeasurement: shoppingItem.preferredMeasurement ?? "pack")
                                    NavigationLink("", destination: DetailView (itemToBeDisplayed: shoppingItem))
                                } /// End of HStack
                            }
                            .onDelete(perform: self.deleteItem)
                            .onMove(perform: moveItem)
                        } /// End of Section
                        .frame(alignment: .leading)
                        .listStyle(PlainListStyle())
                        .listRowBackground(Color(BackgroundColours.defaultBackground.rawValue)
                            .edgesIgnoringSafeArea(.all))
                    } /// End of List
                    .padding(.top)
                    .padding(.leading, 20)
                    .listRowSeparator(.hidden)
                } /// End VStack
                .id(UUID())
                .listStyle(PlainListStyle())
                .navigationBarTitleDisplayMode(.inline)

                // MARK: - NavigationBarItem: Trailing item will let the user enter an item
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: NewEntryView()
                            .navigationTitle(stringStore.addItem)
                            .frame(minWidth: 0,
                                   idealWidth: 0,
                                   maxWidth: .infinity,
                                   minHeight: 0,
                                   idealHeight: 0,
                                   maxHeight: .infinity,
                                   alignment:.center)
                                .edgesIgnoringSafeArea(.all)
                        ){
                            Image(ContentViewImages.plusImage.rawValue)
                                .frame(width: 35,
                                       height: 35)
                                .cornerRadius(38.5)
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

extension PopulatedView {
    /// Triggered for when the user is in EditMode and wishes to move an item on the list
    public func moveItem(from source: IndexSet, to destination: Int) {
        DispatchQueue.main.async {
            /// An array of them items from the fetched results
            var orderedItems: [ShoppingItems] = shoppingItemEntries.map{$0}

            /// Alter the order of the items in the new array
            orderedItems.move(fromOffsets: source,
                              toOffset: destination)
        }
    }

    public func deleteItem(at indexSet: IndexSet) {
        DispatchQueue.main.async {
            /// When the user wants to delete a cell, the index of the selected cell is found and then removed
            let deleteItem = self.shoppingItemEntries[indexSet.first!]

            // This tiny line now deals with deleting an item from the model
            self.modelContext.delete(deleteItem)
            self.generator.notificationOccurred(.error)
        }
    }
}
