//
//  PopulatedViewExtension.swift
//  Yer Messages
//
//  Created by Marc Harvey on 12/06/2024.
//  Copyright © 2024 Marc Harvey. All rights reserved.
//

import Foundation

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
