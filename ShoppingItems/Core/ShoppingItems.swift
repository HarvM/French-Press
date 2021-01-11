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
    
//    static func getListItemFetchRequest() -> NSFetchRequest<ShoppingItems>{
//    let request = ShoppingItems.fetchRequest() as! NSFetchRequest<ShoppingItems>
//            request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
//    return request
//        }
//    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingItems> {
        return NSFetchRequest<ShoppingItems>(entityName: "ShoppingItems")
    }
    @NSManaged public var itemToBeAdded: String
    @NSManaged public var quantitySelected: String
    @NSManaged public var notesOnItem: String
    @NSManaged public var id: UUID
    @NSManaged public var preferredMeasurement: String
    @NSManaged public var order: Int
}
