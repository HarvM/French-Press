//
//  ShoppingItemsTest.swift
//  ShoppingItemsTests
//
//  Created by Marc Harvey on 18/01/2021.
//  Copyright © 2021 Marc Harvey. All rights reserved.
//

import XCTest
import CoreData

@testable import Yer_Messages

class ShoppingItemsTest: XCTestCase {
    
    //MARK: - NOTE TO SELF: Need to sort how the CoreData is managed in "Shopping Items"
    
    
    var coreData = ShoppingItems()
    let context = UnitTestHelpers.setUpInMemoryManagedObjectContext()

    override func setUpWithError() throws {
        //Puts our test context onto the CoreData model
        coreData = self.context
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    // Simple test to ensure that the model is in place
    func testModel() {
        let modelExist = coreData.context
        XCTAssert((modelExist != nil))
    }
    
    // Test to ensure that initally there are no items in the model
       func testEmptyFetch() {
           let fetchRequest = ShoppingItems.fetchRequest() as
               NSFetchRequest<ShoppingItems>
           do {
               let results = try context.fetch(fetchRequest)
               XCTAssert(results.count == 0)
           } catch {
               XCTFail("Nothing should have been fetched from an empty model")
           }
       }
    
    // Test to ensure that all objects are removed from the model and that nothing should be fetched after
    func testEnsureEmpty() {
        let fetchRequest = ShoppingItems.fetchRequest() as
            NSFetchRequest<ShoppingItems>
        do {
            try UnitTestHelpers.deleteAllObjects(objectType: ShoppingItems.self, withContext: context)
            let result = try context.fetch(fetchRequest)
            XCTAssert(result.count == 0, "Nothing should be found here")
        } catch {
            print("Error: \(error.localizedDescription)")
            XCTFail("Couldn't remove the objects")}
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
