//
//  ShoppingItems.swift
//  Yer Messages
//
//  Created by Marc Harvey on 07/07/2023.
//  Copyright © 2023 Marc Harvey. All rights reserved.
//
//

import Foundation
import SwiftData

// Auto generated too - click on existing Model -> Editor -> Create SwiftDataCode
// Super simple
@Model public class ShoppingItems {
    var id: UUID?
    var itemToBeAdded: String
    var notesOnItem: String
    var order: Int16 = 0
    var preferredMeasurement: String
    var quantitySelected: String

    // Auto generated - sweet
    init(id: UUID? = nil, itemToBeAdded: String, notesOnItem: String, order: Int16, preferredMeasurement: String, quantitySelected: String) {
        self.id = id
        self.itemToBeAdded = itemToBeAdded
        self.notesOnItem = notesOnItem
        self.order = order
        self.preferredMeasurement = preferredMeasurement
        self.quantitySelected = quantitySelected
    }



}
