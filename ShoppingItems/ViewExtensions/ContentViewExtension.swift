//
//  ContentViewExtension.swift
//  Yer Messages
//
//  Created by Marc Harvey on 11/04/2021.
//  Copyright © 2021 Marc Harvey. All rights reserved.
//

import Foundation
import SwiftUI

extension ContentView {
    
    /// Func that will display the hamburger menu
    public func openMenu() {
        self.showHamburgerMenu.toggle()
    }
    
    /// Func that will delete the item that the user has selected
    public func deleteItem(at indexSet: IndexSet) {
        DispatchQueue.main.async {
            /// When the user wants to delete a cell, the index of the selected cell is found and then removed
            let deleteItem = self.shoppingItemEntries[indexSet.first!]
            self.managedObjectContext.delete(deleteItem)
            
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
            for reverseIndex in stride(from: orderedItems.count - 1,
                                       through: 0,
                                       by: -1) {
                orderedItems[reverseIndex].order =
                NSNumber(value: Int16(reverseIndex))
                
                /// The change in order has to be saved
                do {
                    try self.managedObjectContext.save()
                } catch {
                    Alert(title: Text(stringStore.sorry),
                          message: Text(stringStore.pleaseTryAgain),
                          dismissButton: .default(Text(stringStore.okay)))
                }
            }
        }
    }
}
