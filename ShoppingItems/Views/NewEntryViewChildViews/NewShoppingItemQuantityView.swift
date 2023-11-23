//
//  NewShoppingItemQuantityView.swift
//  Yer Messages
//
//  Created by Marc Harvey on 26/06/2022.
//  Copyright © 2022 Marc Harvey. All rights reserved.
//

import SwiftUI

struct NewShoppingItemQuantityView: View {
    
    let stringStore = StringStore()
    @ObservedObject var newShoppingItemQuantity: ItemQuantity
    
    var body: some View {
        TextField(stringStore.typeQuantityHere,
                  text: $newShoppingItemQuantity.newItemQuantity.text)
            .frame (height: 40)
            .multilineTextAlignment(.leading)
            .keyboardType(.decimalPad)
            .font(.custom(DefaultFont.defaultFont.rawValue,
                          size: 16,
                          relativeTo: .headline))
            .ignoresSafeArea(.keyboard,
                             edges: .bottom)
    }
}

class ItemQuantity: ObservableObject {
    init(newItemQuantity: TextLimit = TextLimit(limit: 6)) {
        self.newItemQuantity = newItemQuantity
    }
    @Published var newItemQuantity = TextLimit(limit: 6)
}

//struct NewShoppingItemQuantityView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewShoppingItemQuantityView(newShoppingItemQuantity: self.newShoppingItemQuantity.newItemQuantity.text)
//    }
//}

