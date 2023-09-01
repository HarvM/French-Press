//
//  NewShoppingItemSectionView.swift
//  Yer Messages
//
//  Created by Marc Harvey on 26/06/2022.
//  Copyright © 2022 Marc Harvey. All rights reserved.
//

import SwiftUI
import SwiftData

struct NewShoppingItemSectionView: View {
    
    let stringStore = StringStore()
    @ObservedObject var newShoppingItem: ShoppingItem
    @Environment(\.modelContext) private var context

    var body: some View {
        /// $newShoppingItem to get the binding to the state newShoppingItem
        TextField(stringStore.typeTheItemHere, text: $newShoppingItem.itemTitleWithTextLimit.text)
            .frame (height: 40)
            .multilineTextAlignment(.leading)
            .font(.custom(DefaultFont.defaultFont.rawValue, size: 16, relativeTo: .headline))
        /// Will display the number of characters already typed and the limit
        Text("\(newShoppingItem.itemTitleWithTextLimit.text.count)|30")
            .font(.custom(DefaultFont.defaultFont.rawValue, size: 16, relativeTo: .headline))
            .foregroundColor(.gray)
    }
}

class ShoppingItem: ObservableObject {
    init(itemTitleWithTextLimit: TextLimit = TextLimit(limit: 40)) {
        self.itemTitleWithTextLimit = itemTitleWithTextLimit
    }
    var itemTitleWithTextLimit = TextLimit(limit: 40)
}

//
//struct NewShoppingItemSectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewShoppingItemSectionView()
//    }
//}
