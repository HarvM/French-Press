import SwiftUI

@available(iOS 17.0, *)
extension NewEntryView {
    func saveShoppingitem(itemToBeAdded: String,
                          notesOnItem: String,
                          quantitySelected: String,
                          preferredMeasurement: String) {

        let trimmedItem = itemToBeAdded.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedNote = notesOnItem.trimmingCharacters(in: .whitespacesAndNewlines)
        let chosenMeasurement = self.stringStore.measurementFound[selectedMeasurement.newItemMeasurement]
        var trimmedQuantity = quantitySelected.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmedQuantity.isEmpty  {
            trimmedQuantity = "1"
        }

        if trimmedItem.isEmpty {
            showingAlert.toggle()
        } else {
            let shoppingItem = ShoppingItems(itemToBeAdded: trimmedItem,
                                             notesOnItem: trimmedNote,
                                             preferredMeasurement: chosenMeasurement,
                                             quantitySelected: trimmedQuantity)
            context.insert(shoppingItem)
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }

            self.generator.notificationOccurred(.success)
            self.presentationMode.wrappedValue.dismiss()
        }
    }

    /// Will take a random "treatItems" and then put it into the SwiftData model and then display it on the user's list
    public func weeTreat() {
        DispatchQueue.main.async {
            let randomTreat = stringStore.treatItems.randomElement()!

            saveShoppingitem(itemToBeAdded: randomTreat.key,
                             notesOnItem: randomTreat.value,
                             quantitySelected: "\(stringStore.treatEmoji)",
                             preferredMeasurement: "\(stringStore.treatEmoji)")
        }
    }
}
