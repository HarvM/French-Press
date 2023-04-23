//
//  ShoppingListViewModel.swift
//  Yer Messages
//
//  Created by Marc Harvey on 21/04/2023.
//  Copyright © 2023 Marc Harvey. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

class ShoppingListViewModel: ObservableObject {
    @Environment(\.presentationMode) var presentationMode
    @Published var shoppingItems = [ShoppingItems]()

    func fetchData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ShoppingItems")
        let sortDescriptor = NSSortDescriptor(key: "order", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        do {
            let result = try PersistenceController.shared.container.viewContext.fetch(request)
            self.shoppingItems = result as! [ShoppingItems]
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
    }

    func addItem(itemToBeAdded: String, quantitySelected: String, notesOnItem: String, preferredMeasurement: String) {
        let newItem = ShoppingItems(context: PersistenceController.shared.container.viewContext)
        newItem.itemToBeAdded = itemToBeAdded
        newItem.quantitySelected = quantitySelected
        newItem.notesOnItem = notesOnItem
        newItem.id = UUID()
        newItem.preferredMeasurement = preferredMeasurement

        self.presentationMode.wrappedValue.dismiss()
        
        do {
            try PersistenceController.shared.container.viewContext.save()
            self.fetchData()
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }

    func deleteItem(item: ShoppingItems) {
        PersistenceController.shared.container.viewContext.delete(item)
        do {
            try PersistenceController.shared.container.viewContext.save()
            self.fetchData()
        } catch {
            print("Error deleting data: \(error.localizedDescription)")
        }
    }

}
