import SwiftUI

@available(iOS 17.0, *)
extension NewEntryView {
    @MainActor func saveShoppingitem(itemToBeAdded: String,
                                     notesOnItem: String,
                                     quantitySelected: String,
                                     preferredMeasurement: String) {
        var trimmedItem = itemToBeAdded.trimmingCharacters(in: .whitespacesAndNewlines)
        var trimmedNote = notesOnItem.trimmingCharacters(in: .whitespacesAndNewlines)
        var trimmedQuantity = quantitySelected.trimmingCharacters(in: .whitespacesAndNewlines)
        let chosenMeasurement = self.stringStore.measurementFound[$selectedMeasurement.userSelectedMeasurement.wrappedValue]

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
            save(shoppingItem: shoppingItem)
            trimmedItem = ""
            trimmedNote = ""
            trimmedQuantity = ""
        }
    }

    @MainActor private func save(shoppingItem: ShoppingItems) {
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
