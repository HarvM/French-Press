//
//  ShoppingItems.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 05/01/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import Foundation
import CoreData

///Fetches the defined elements both defined already and added by the user
extension ShoppingItems {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingItems> {
        return NSFetchRequest<ShoppingItems>(entityName: "ShoppingItems")
    }
    @NSManaged public var itemToBeAdded: String
    @NSManaged public var quantitySelected: String
    @NSManaged public var notesOnItem: String
    @NSManaged public var id: UUID
    @NSManaged public var preferredMeasurement: String
}
