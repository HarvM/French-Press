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
    
    var viewModel: ShoppingItemViewModel!
    
    override func setUp() {
        super.setUp()
        
        let inMemoryStoreDescription = NSPersistentStoreDescription()
        inMemoryStoreDescription.url = URL(fileURLWithPath: "/dev/null")
        
        let container = NSPersistentContainer(name: "TestContainer")
        container.persistentStoreDescriptions = [inMemoryStoreDescription]
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error loading Core Data: \(error.localizedDescription)")
            }
        }
        
        viewModel = ShoppingItemViewModel()
        viewModel.container = container
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewModel = nil
    }
    
    func testAddItem() {
        let item = ShoppingItems(context: viewModel.container.viewContext)
        item.itemToBeAdded = "Milk"
        item.quantitySelected = "1"
        item.preferredMeasurement = "Litre"
        item.order = 0
        
        viewModel.addItem(item)
        
        XCTAssertEqual(viewModel.shoppingItems.count, 1)
        XCTAssertEqual(viewModel.shoppingItems[0].itemToBeAdded, "Milk")
        XCTAssertEqual(viewModel.shoppingItems[0].quantitySelected, "1")
        XCTAssertEqual(viewModel.shoppingItems[0].preferredMeasurement, "Litre")
        XCTAssertEqual(viewModel.shoppingItems[0].order, 0)
    }
    
    func testDeleteItem() {
        let item = ShoppingItems(context: viewModel.container.viewContext)
        item.itemToBeAdded = "Milk"
        item.quantitySelected = "1"
        item.preferredMeasurement = "Litre"
        item.order = 0
        
        viewModel.addItem(item)
        XCTAssertEqual(viewModel.shoppingItems.count, 1)
        
        viewModel.deleteItem(item)
        XCTAssertEqual(viewModel.shoppingItems.count, 0)
    }
    
    func testFetchItems() {
        let item1 = ShoppingItems(context: viewModel.container.viewContext)
        item1.itemToBeAdded = "Milk"
        item1.quantitySelected = "1"
        item1.preferredMeasurement = "Litre"
        item1.order = 0
        
        let item2 = ShoppingItems(context: viewModel.container.viewContext)
        item2.itemToBeAdded = "Eggs"
        item2.quantitySelected = "12"
        item2.preferredMeasurement = "Count"
        item2.order = 1
        
        viewModel.addItem(item1)
        viewModel.addItem(item2)
        
        viewModel.fetchItems()
        
        XCTAssertEqual(viewModel.shoppingItems.count, 2)
        XCTAssertEqual(viewModel.shoppingItems[0].itemToBeAdded, "Milk")
        XCTAssertEqual(viewModel.shoppingItems[0].quantitySelected, "1")
        XCTAssertEqual(viewModel.shoppingItems[0].preferredMeasurement, "Litre")
        XCTAssertEqual(viewModel.shoppingItems[0].order, 0)
        XCTAssertEqual(viewModel.shoppingItems[1].itemToBeAdded, "Eggs")
        XCTAssertEqual(viewModel.shoppingItems[1].quantitySelected, "12")
        XCTAssertEqual(viewModel.shoppingItems[1].preferredMeasurement, "Count")
        XCTAssertEqual(viewModel.shoppingItems[1].order, 1)
    }
    
}
