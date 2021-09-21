//
//  ShoppingItemsStore.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 09/01/2021.
//  Copyright © 2021 Marc Harvey. All rights reserved.
//

import SwiftUI

final class ShoppingItemStore: ObservableObject {
    @Published var shoppingItems: [ShoppingItems]
    
    init(shoppingItems: [ShoppingItems] = []) {
        self.shoppingItems = shoppingItems
    }
}
