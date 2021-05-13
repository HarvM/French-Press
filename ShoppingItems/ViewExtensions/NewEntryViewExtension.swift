//
//  NewEntryViewExtension.swift
//  Yer Messages
//
//  Created by Marc Harvey on 11/04/2021.
//  Copyright © 2021 Marc Harvey. All rights reserved.
//

import SwiftUI

extension NewEntryView {
    
    public func weeTreat() {
        
        print("Hey")
    }
    
    //MARK: - Function (saves the user's item [item name, quantity, measurement, and extra notes]
    public func saveNewEntry() {
        DispatchQueue.main.async {
            print("Checking input")
            ///Removes the whitespace and newLines from the item as it messes with how the name is displayed on the ContentView
            let trimmedItem = self.newShoppingItem.text.trimmingCharacters(in: .whitespacesAndNewlines)
            let trimmedNote = self.notesOnItem.text.trimmingCharacters(in: .whitespacesAndNewlines)
            var trimmedQuantity = self.quantitySelected.text.trimmingCharacters(in: .whitespacesAndNewlines)
            let chosenMeasurement = self.measurementFound[self.selectedMeasurement]
            
            ///There has to be a value within the "itemsToBeAdded" or else nothing will be saved
            if trimmedItem.isEmpty {
                self.showAlert = true
            } 
            else {
                ///Will get the new item and then place it within the CoreData under the attribute of itemToBeAdded
                let shoppingItemNew = ShoppingItems(context: self.managedObjectContext)
                self.managedObjectContext.performAndWait {
                    shoppingItemNew.itemToBeAdded = trimmedItem
                    shoppingItemNew.notesOnItem = trimmedNote
                    shoppingItemNew.quantitySelected = trimmedQuantity
                    shoppingItemNew.preferredMeasurement = chosenMeasurement
                    self.isShowingContentView = true
                    
                    ///Will save the new entry but if not the user will be notified that there was an issue saving to to the device
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        Alert(title: Text("Sorry \(ContentViewImages.sorryShrug.rawValue)"), message: Text("Please try again"), dismissButton: .default(Text("")))
                    }
                    
                    ///Logic to ensure that there is a quantity of some sort by default even if the user doesn't explicity define an amount
                    if trimmedQuantity.isEmpty {
                        shoppingItemNew.quantitySelected = "1"
                    }
                    
                    ///Resets the newShoppingItem back to being blank
                    newShoppingItem.text = ""
                    notesOnItem.text = ""
                    
                    ///Haptic feedback for when the user has tapped on the Add/Plus button
                    self.generator.notificationOccurred(.success)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}
