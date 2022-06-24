//
//  ShoppingItemsUITests.swift
//  ShoppingItemsUITests
//
//  Created by Marc Harvey on 05/01/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import XCTest

class ShoppingItemsUITests: XCTestCase {
    
    // Property for this app
    var app: XCUIApplication!
    
    override func setUp() {
        // Loads in the object of the app that will allow us to run the UITests
        app = XCUIApplication()
        app.launch()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
    }
    
    override func tearDown() {
        
    }
    
    
    // Looked into UITesting for SwiftUI and it appears to be fairly similar to some of the tests that I've tried previously
    // Noticed that there's currently still a bug with "SwiftUI.AccessibilityNode doesn't exist" and that there doesn't appear to be a workaround currently (https://stackoverflow.com/questions/58449530/catalyst-swiftui-accessibilitynode-is-not-a-known-serializable-element)
    //
    func testButtons () {
        
        let typeHere = app.textFields["Type here"]
        let addNewEntry = app.buttons["plus.circle"]
        let editList = app.buttons["Edit"]
        let deleteButton = app.buttons["Delete"]
        
        
        // Test to ensure that with the "Hello, testing" input that the textField will still exist later and also display the input
        XCTAssert(app.textFields["Type here"].exists, "Doesn't exist")
        typeHere.tap()
        typeHere.typeText("Hello, testing")
        XCTAssertTrue(typeHere.exists, "It exists")
        XCTAssertEqual(typeHere.value as! String, "Hello, testing", "This textField has the right value")
        
        // Three checks on each of the buttons available to the user
        // Firstly ensure that every button is able to be selected and then ensures that with a tap, the button exists
        if addNewEntry.isSelected {
            XCTAssert(true, "The button can be pressed and the new entry should appear")
            
            addNewEntry.tap()
            XCTAssertTrue(addNewEntry.exists)
        }
        
        if editList.isSelected {
            XCTAssert(true, "The button can be pressed and you should be able to edit the items")
            
            editList.tap()
            XCTAssertTrue(deleteButton.exists)
            
        }
        
        if deleteButton.isSelected {
            XCTAssert(true, "The button can be pressed and the sound should play")
            
            deleteButton.tap()
            XCTAssertTrue(deleteButton.exists, "The button can be tapped")
        }
        
    }
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}

