//
//  UnitTestHelpers.swift
//  ShoppingItemsTests
//
//  Created by Marc Harvey on 18/01/2021.
//  Copyright © 2021 Marc Harvey. All rights reserved.
//

import XCTest
import CoreData

@testable import Yer_Messages

enum CoreDataError: Error {
    case missingContext
    case errorWhileDeleting
    case couldNotCreateFetchRequest
    case errorWhileFetchingData
}

class UnitTestHelpers: XCTestCase {
    
    class func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
        
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            fatalError("Adding in-memory persistent store failed")
        }
        
        let context = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        
        /* create a dummy object, then delete it.  this avoids fetch request errors later */
        let testObject = ShoppingItems(context: context)
        context.delete(testObject)
        do {
            try context.save()
        } catch {
            fatalError("Unable to save context")
        }
        
        return context
    }
    
    class func deleteAllObjects<T: NSManagedObject>(objectType: T.Type, withContext moc: NSManagedObjectContext) throws {
        guard let fetchRequest: NSFetchRequest<T> = T.fetchRequest() as? NSFetchRequest<T> else {
            throw CoreDataError.couldNotCreateFetchRequest
        }
        do {
            let results = try moc.fetch(fetchRequest)
            print("Found \(results.count) objects of type \(T.description())")
            results.forEach { object in
                moc.delete(object)
            }
            try moc.save()
        } catch {
            throw CoreDataError.couldNotCreateFetchRequest
        }
    }
    
    class func fetchObjects<T: NSManagedObject>(withContext context: NSManagedObjectContext, sortedBy: String?, ascending: Bool?) throws -> [T] {
        guard let fetchRequest = T.fetchRequest() as? NSFetchRequest<T> else {
            throw CoreDataError.couldNotCreateFetchRequest
        }
        if let sortBy = sortedBy, let ascending = ascending {
            let sortDescriptor = NSSortDescriptor(key: sortBy, ascending: ascending)
            let sortDescriptors = [sortDescriptor]
            fetchRequest.sortDescriptors = sortDescriptors
        }
        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            throw CoreDataError.errorWhileFetchingData
        }
    }
}

