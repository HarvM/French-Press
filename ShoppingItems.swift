//
//  ShoppingItems.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 15/01/2021.
//  Copyright © 2021 Marc Harvey. All rights reserved.
//

import Foundation
import CoreData

//The objects that are saved to the CoreData model
final public class ShoppingItems: NSManagedObject, Identifiable {
    @NSManaged public var itemToBeAdded: String
    @NSManaged public var quantitySelected: String
    @NSManaged public var notesOnItem: String
    @NSManaged public var id: UUID
    @NSManaged public var preferredMeasurement: String
    @NSManaged public var order: NSNumber
    
    ///Used in UnitTests
    var context : NSManagedObjectContext? = nil
}

extension ShoppingItems {
    ///Will initially sort the items in the order that they appear
    static func getListItemFetchRequest() -> NSFetchRequest<ShoppingItems>{
        let request = ShoppingItems.fetchRequest() as! NSFetchRequest<ShoppingItems>
        request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
        return request
    }
}
