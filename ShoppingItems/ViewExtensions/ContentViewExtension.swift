import Foundation
import SwiftUI
import SwiftData

@available(iOS 17.0, *)
extension ContentView {

    public func openMenu() {
        self.showHamburgerMenu.toggle()
    }
    
    /// Func that will delete the item that the user has selected
    public func deleteItem(at indexSet: IndexSet) {
        DispatchQueue.main.async {
            /// When the user wants to delete a cell, the index of the selected cell is found and then removed
            let deleteItem = self.shoppingItemEntries[indexSet.first!]

            // This tiny line now deals with deleting an item from the model
            self.modelContext.delete(deleteItem)
            // Old way
            // self.managedObjectContext.delete(deleteItem)

            self.generator.notificationOccurred(.error)
        }
    }
    
    /// Triggered for when the user is in EditMode and wishes to move an item on the list
    public func moveItem(from source: IndexSet, to destination: Int) {
        DispatchQueue.main.async {
            /// An array of them items from the fetched results
            var orderedItems: [ShoppingItems] = shoppingItemEntries.map{$0}
            
            /// Alter the order of the items in the new array
            orderedItems.move(fromOffsets: source,
                              toOffset: destination)
            
            /// Updates the userOrder to maintain the new order
            /// Done in reverse to minimise changes to indices of the array
//            for reverseIndex in stride(from: orderedItems.count - 1,
//                                       through: 0,
//                                       by: -1) {
//                orderedItems[reverseIndex].order =
//                Int16(truncating: NSNumber(value: Int16(reverseIndex)))

                // Saving done in the background now so can stop the use of the below
                /// The change in order has to be saved
//                do {
//                    try self.managedObjectContext.save()
//                } catch {
//                    Alert(title: Text(stringStore.sorry),
//                          message: Text(stringStore.pleaseTryAgain),
//                          dismissButton: .default(Text(stringStore.okay)))
//                }
            }
        }
}
