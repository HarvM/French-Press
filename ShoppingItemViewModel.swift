//
//  ShoppingItemViewModel.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 09/01/2021.
//  Copyright © 2021 Marc Harvey. All rights reserved.
//

import SwiftUI
import Foundation
import CoreData

class ShoppingItemViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    
    @Published var shoppingItems: [ShoppingItems] = []
    
    init() {
        container = NSPersistentContainer(name: "ShoppingItemContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data: \(error.localizedDescription)")
            }
        }
        
        fetchItems()
    }
    
    func fetchItems() {
        let request = NSFetchRequest<ShoppingItems>(entityName: "ShoppingItems")
        request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
        
        do {
            shoppingItems = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching items: \(error.localizedDescription)")
        }
    }
    
    func addItem(_ shoppingItem: ShoppingItems) {
        shoppingItems.append(shoppingItem)
        saveContext()
    }
    
    func deleteItem(_ shoppingItem: ShoppingItems) {
        container.viewContext.delete(shoppingItem)
        saveContext()
    }
    
    private func saveContext() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
        
        fetchItems()
    }
}
