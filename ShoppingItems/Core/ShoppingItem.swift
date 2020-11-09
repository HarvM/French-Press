//
//  ShoppingItem .swift
//  ShoppingItems
//
//  Created by Marc Harvey on 05/01/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import Foundation
import CoreData

//Identifiable: new protocol item for SwiftUI
//Means that this class will hold the value of an entity with a stable identity
//Public so accessible but not subclassable
public class ShoppingItem: NSManagedObject, Identifiable {
    
    //NSManaged means: compiler won't have to check if below are there as we are planning on using CoreData and it will be there at runtime
    @NSManaged public var itemToBeAdded: String?
    @NSManaged public var quantityOfItem: Int
    @NSManaged public var notesOnItem: String?
}

//Fetches the defined elements both defined already and added by the user
extension ShoppingItem {
   
    //Func will handle the NSFetchRequest for the model
    static func getAllShoppingItems() -> NSFetchRequest<ShoppingItem> {
        let request: NSFetchRequest <ShoppingItem> = ShoppingItem.fetchRequest() as! NSFetchRequest <ShoppingItem>
        
        //Was formerly trying to sort this but the date but it was being peculiar after 4/5 entries
        //Changed it to sort alphabetically instead 
        let sortShoppingItems = NSSortDescriptor(key: "itemToBeAdded", ascending: true)
        
        //Runs the sort on the request above and has it sorted with the sortShoppingItems immediately above
        request.sortDescriptors = [sortShoppingItems]
        
        //Returns the item so that it's ready to be used
        //To be used in the ContentView with the NSFetchRequest
        return request
    }
}
