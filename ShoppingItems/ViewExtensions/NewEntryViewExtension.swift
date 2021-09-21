//
//  NewEntryViewExtension.swift
//  Yer Messages
//
//  Created by Marc Harvey on 11/04/2021.
//  Copyright © 2021 Marc Harvey. All rights reserved.
//

import SwiftUI

extension NewEntryView {
    
    ///Func that will pass through either of the save points that the user could use to save an entry
    public func saveEntryToCoreModel(itemToBeAdded: String, notesOnItem: String, quantitySelected: String, preferredMeasurement: String) {
        
        DispatchQueue.main.async {
            ///Refactor the saving the to the CoreData model here
            let itemToBeSaved = ShoppingItems(context: self.managedObjectContext)
            
            self.managedObjectContext.performAndWait {
                itemToBeSaved.itemToBeAdded = itemToBeAdded.self
                itemToBeSaved.notesOnItem = notesOnItem.self
                itemToBeSaved.quantitySelected = quantitySelected.self
                itemToBeSaved.preferredMeasurement = preferredMeasurement.self
                self.isShowingContentView = true
            }
            
            ///Will make an attempt to save the data to the CoreData model
            do {
                try self.managedObjectContext.save()
            } catch {
                ///Will throw an alert to the user should an issue occur
                Alert(title: Text("Sorry \(ContentViewImages.sorryShrug.rawValue)"), message: Text("Please try again"), dismissButton: .default(Text("")))
            }
            
            ///Logic to ensure that there is a quantity of some sort by default even if the user doesn't explicity define an amount
            if quantitySelected.isEmpty && quantitySelected != "🎁" {
                itemToBeSaved.quantitySelected = "1"
            }
            
            ///Partners with "isShowingContentView" to ensure that the user is kicked back to the ContentView
            self.presentationMode.wrappedValue.dismiss()
            ///Haptic feedback for when an item has been added
            self.generator.notificationOccurred(.success)
        }
    }
    
    
    ///This func will take a random entry and then put it into the CoreData model and then display it on the user's list
    public func weeTreat() {
        DispatchQueue.main.async {
            ///Dictionary of all the options that a user could end up having thrown onto their list should they click the
            let treatItems = ["Chocolate bar": "Just think of this and tea",
                              "That magazine": "One step closer to that subscription",
                              "Fizzy juice": "There is an orange coloured one that's pretty decent",
                              "Celebratory drink": "You nailed it - whatever it was",
                              "Fruit": "There's mango and all of the lesser fruits",
                              "Crisps": "Eating your own body weight in this is not a crime",
                              "Ice cream": "Not much else to be said here",
                              "Cake": "Have it and eat it",
                              "Dips": "Guacamole owns my soul but whatever you want",
                              "Popcorn": "For the next movie night",
                              "Smoothie": "We can all be innocent sometimes",
                              "Pizza": "A slice/with pineapple/frozen - they're all beautiful",
                              "Dog treat": "A snack waiting to be tried if you don't have a dog...",
                              "Apple": "The product placement Apple didn't know they need...",
                              "Comfort food": "We all have that one meal that just puts things right"
            ]
            
            ///Gets a random element from the dictionary above
            let randomTreat = treatItems.randomElement()!
            
            ///Call of the func that will save the entry to the CoreDate model
            saveEntryToCoreModel(itemToBeAdded: randomTreat.key, notesOnItem: randomTreat.value, quantitySelected: "🎁", preferredMeasurement: "🎁")
        }
    }
    
    ///Function (saves the user's item [item name, quantity, measurement, and extra notes]
    public func saveNewEntry() {
        DispatchQueue.main.async {
            ///Removes the whitespace and newLines from the item as it messes with how the name is displayed on the ContentView
            let trimmedItem = self.newShoppingItem.text.trimmingCharacters(in: .whitespacesAndNewlines)
            let trimmedNote = self.notesOnItem.text.trimmingCharacters(in: .whitespacesAndNewlines)
            let trimmedQuantity = self.quantitySelected.text.trimmingCharacters(in: .whitespacesAndNewlines)
            let chosenMeasurement = self.measurementFound[self.selectedMeasurement]
            
            ///There has to be a value within the "itemsToBeAdded" or else nothing will be saved
            if trimmedItem.isEmpty {
                self.showAlert = true
            } 
            else {
                ///Call of the func that will save the entry to the CoreDate model
                ///Moves the trimmed items into the func
                saveEntryToCoreModel(itemToBeAdded: trimmedItem, notesOnItem: trimmedNote, quantitySelected: trimmedQuantity, preferredMeasurement: chosenMeasurement)
                
                ///Resets the newShoppingItem back to being blank
                newShoppingItem.text = ""
                notesOnItem.text = ""
            }
        }
    }
}
