//
//  NewEntryViewExtension.swift
//  Yer Messages
//
//  Created by Marc Harvey on 11/04/2021.
//  Copyright © 2021 Marc Harvey. All rights reserved.
//

import SwiftUI

extension NewEntryView {
    
    /// Func that will pass through either of the save points that the user could use to save an entry
    public func saveEntryToCoreModel(itemToBeAdded: String,
                                     notesOnItem: String,
                                     quantitySelected: String,
                                     preferredMeasurement: String) {
        
        DispatchQueue.main.async {
            /// Refactor the saving the to the CoreData model here
            let itemToBeSaved = ShoppingItems(context: self.managedObjectContext)
            
            self.managedObjectContext.performAndWait {
                itemToBeSaved.itemToBeAdded = itemToBeAdded.self
                itemToBeSaved.notesOnItem = notesOnItem.self
                itemToBeSaved.quantitySelected = quantitySelected.self
                itemToBeSaved.preferredMeasurement = preferredMeasurement.self
                self.isShowingContentView = true
            }
            
            /// Will make an attempt to save the data to the CoreData model
            do {
                try self.managedObjectContext.save()
            } catch {
                /// Will throw an alert to the user should an issue occur
                Alert(title: Text("\(stringStore.sorry + ContentViewImages.sorryShrug.rawValue)"),
                      message: Text(stringStore.pleaseTryAgain),
                      dismissButton: .default(Text("")))
            }
            
            /// Logic to ensure that there is a quantity of some sort by default even if the user doesn't explicitly defines an amount
            if quantitySelected.isEmpty && quantitySelected != "\(stringStore.treatEmoji)" {
                itemToBeSaved.quantitySelected = "1"
            }
            
            /// Partners with "isShowingContentView" to ensure that the user is kicked back to the ContentView
            self.presentationMode.wrappedValue.dismiss()
            /// Haptic feedback for when an item has been added
            self.generator.notificationOccurred(.success)
        }
    }
    
    
    /// This func will take a random entry and then put it into the CoreData model and then display it on the user's list
    public func weeTreat() {
        DispatchQueue.main.async {
            /// Gets a random element from the dictionary above
            let randomTreat = stringStore.treatItems.randomElement()!
            
            /// Call of the func that will save the entry to the CoreDate model
            saveEntryToCoreModel(itemToBeAdded: randomTreat.key,
                                 notesOnItem: randomTreat.value,
                                 quantitySelected: "\(stringStore.treatEmoji)",
                                 preferredMeasurement: "\(stringStore.treatEmoji)")
        }
    }
    
    /// Function (saves the user's item [item name, quantity, measurement, and extra notes]
    public func saveNewEntry() {
        DispatchQueue.main.async {
            let trimmedItem = newShoppingItem.newItem.text.trimmingCharacters(in: .whitespacesAndNewlines)
            let trimmedNote = notesOnItem.notesOnItem.text.trimmingCharacters(in: .whitespacesAndNewlines)
            let trimmedQuantity = quantitySelected.newItemQuantity.text.trimmingCharacters(in: .whitespacesAndNewlines)
            let chosenMeasurement = self.stringStore.measurementFound[selectedMeasurement.newItemMeasurement]
            
            /// There has to be a value within the "itemsToBeAdded" or else nothing will be saved
            if trimmedItem.isEmpty{
                self.showAlert = true
            } 
            else {
                /// Call of the func that will save the entry to the CoreDate model
                /// Moves the trimmed items into the func
                saveEntryToCoreModel(itemToBeAdded: trimmedItem,
                                     notesOnItem: trimmedNote,
                                     quantitySelected: trimmedQuantity,
                                     preferredMeasurement: chosenMeasurement)
                
                /// Resets the newShoppingItem back to being blank
                newShoppingItem.newItem.text = ""
                notesOnItem.notesOnItem.text = ""
            }
        }
    }
}
