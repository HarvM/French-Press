import SwiftUI

@available(iOS 17.0, *)
extension NewEntryView {
//    public func saveSwiftDataItem(itemToBeAdded: String,
//                                  notesOnItem: String,
//                                  quantitySelected: String,
//                                  preferredMeasurement: String) {
//
//        let shoppingItems = ShoppingItems(itemToBeAdded: itemToBeAdded,
//                                          notesOnItem: notesOnItem,
//                                          preferredMeasurement: preferredMeasurement,
//                                          quantitySelected: quantitySelected)
//        context.insert(shoppingItems)
//        do {
//            try context.save()
//        } catch {
//            print(error.localizedDescription)
//        }
//        presentationMode.wrappedValue.dismiss()
//    }

    /// Func that will pass through either of the save points that the user could use to save an entry
    public func saveSwiftDataItem(itemToBeAdded: String,
                                  notesOnItem: String,
                                  quantitySelected: String,
                                  preferredMeasurement: String) {


        let shoppingItems = ShoppingItems(itemToBeAdded: itemToBeAdded.trimmingCharacters(in: .whitespacesAndNewlines),
                                          notesOnItem: notesOnItem.trimmingCharacters(in: .whitespacesAndNewlines),
                                          preferredMeasurement: quantitySelected.trimmingCharacters(in: .whitespacesAndNewlines),
                                          quantitySelected: self.stringStore.measurementFound[selectedMeasurement.newItemMeasurement])

       // Logic to ensure that there is a quantity of some sort by default even if the user doesn't explicitly defines an amount
        if shoppingItems.quantitySelected.isEmpty && shoppingItems.quantitySelected != "\(stringStore.treatEmoji)" {
            shoppingItems.quantitySelected = "1"
        }

        if shoppingItems.itemToBeAdded.isEmpty {
            // Jumps into here and then doesn't show the Alert to tell the user that they need to enter a value for the initial
            // shopoping item
            self.showAlert = true
        } else {
            context.insert(shoppingItems)
            do {
                try self.context.save()
            } catch {
                Alert(title: Text("\(stringStore.sorry + ContentViewImages.sorryShrug.rawValue)"),
                      message: Text(stringStore.pleaseTryAgain),
                      dismissButton: .default(Text("")))
            }
            self.presentationMode.wrappedValue.dismiss()
            self.generator.notificationOccurred(.success)
        }

        // Partners with "isShowingContentView" to ensure that the user is kicked back to the ContentView

        /// Resets the newShoppingItem back to being blank - check with SwiftData does with fields when dismissing views
//        shoppingItems.itemToBeAdded = ""
//        shoppingItems.notesOnItem = ""

    }


    /// This func will take a random entry and then put it into the CoreData model and then display it on the user's list
    public func weeTreat() {
        DispatchQueue.main.async {
            /// Gets a random element from the dictionary above
            let randomTreat = stringStore.treatItems.randomElement()!

            /// Call of the func that will save the entry to the CoreDate model
            saveSwiftDataItem(itemToBeAdded: randomTreat.key,
                      notesOnItem: randomTreat.value,
                      quantitySelected: "\(stringStore.treatEmoji)",
                      preferredMeasurement: "\(stringStore.treatEmoji)")
        }
    }
}
