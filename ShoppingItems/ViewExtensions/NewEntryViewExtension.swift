//
//  NewEntryViewExtension.swift
//  Yer Messages
//
//  Created by Marc Harvey on 11/04/2021.
//  Copyright © 2021 Marc Harvey. All rights reserved.
//

import SwiftUI

@available(iOS 17.0, *)
extension NewEntryView {
    public func saveSwiftDataItem(itemToBeAdded: String,
                                  notesOnItem: String,
                                  quantitySelected: String,
                                  preferredMeasurement: String) {
        let shoppingItems = ShoppingItems(itemToBeAdded: itemToBeAdded,
                                          notesOnItem: notesOnItem,
                                          preferredMeasurement: preferredMeasurement,
                                          quantitySelected: quantitySelected)
        context.insert(shoppingItems)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        presentationMode.wrappedValue.dismiss()
    }

    /// Func that will pass through either of the save points that the user could use to save an entry
//    public func saveEntry(itemToBeAdded: String,
//                          notesOnItem: String,
//                          quantitySelected: String,
//                          preferredMeasurement: String) {
//        let trimmedItem = itemToBeAdded.trimmingCharacters(in: .whitespacesAndNewlines)
//        let trimmedNote = notesOnItem.trimmingCharacters(in: .whitespacesAndNewlines)
//        let trimmedQuantity = quantitySelected.trimmingCharacters(in: .whitespacesAndNewlines)
//        let chosenMeasurement = self.stringStore.measurementFound[selectedMeasurement.newItemMeasurement]

//        let items = ShoppingItems(itemToBeAdded: "Apples", notesOnItem: "notesOnItem", order: .min, preferredMeasurement: "Bags", quantitySelected: "2")
//        context.insert(items)
        /// There has to be a value within the "itemsToBeAdded" or else nothing will be saved
//        if trimmedItem.isEmpty{
//            self.showAlert = true
//        }

        /// Will make an attempt to save the data to the CoreData model
//        do {
//            try self.context.save()
//            return 
//        } catch {
            /// Will throw an alert to the user should an issue occur
//            Alert(title: Text("\(stringStore.sorry + ContentViewImages.sorryShrug.rawValue)"),
//                  message: Text(stringStore.pleaseTryAgain),
//                  dismissButton: .default(Text("")))
//        }
//
//        // Partners with "isShowingContentView" to ensure that the user is kicked back to the ContentView
//        self.presentationMode.wrappedValue.dismiss()
//        // Haptic feedback for when an item has been added
//        self.generator.notificationOccurred(.success)
//
//        /// Resets the newShoppingItem back to being blank - check with SwiftData does with fields when dismissing views
//        //                newShoppingItem.newItem.text = ""
//        //                notesOnItem.notesOnItem.text = ""
//
//    }


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
