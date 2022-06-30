//
//  NewShoppingItemSectionView.swift
//  Yer Messages
//
//  Created by Marc Harvey on 26/06/2022.
//  Copyright © 2022 Marc Harvey. All rights reserved.
//

import SwiftUI

struct NewShoppingItemSectionView: View {
    
    let stringStore = StringStore()
    @ObservedObject var newShoppingItem: NewItem
    
    var body: some View {
        /// $newShoppingItem to get the binding to the state newShoppingItem
        TextField(stringStore.typeTheItemHere, text: $newShoppingItem.newItem.text)
            .frame (height: 40)
            .multilineTextAlignment(.leading)
            .font(.custom(DefaultFont.defaultFont.rawValue, size: 16, relativeTo: .headline))
        /// Will display the number of characters already typed and the limit
        Text("\(newShoppingItem.newItem.text.count)|30")
            .font(.custom(DefaultFont.defaultFont.rawValue, size: 16, relativeTo: .headline))
            .foregroundColor(.gray)
    }
    
}
//
//struct NewShoppingItemSectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewShoppingItemSectionView()
//    }
//}

class NewItem: ObservableObject {
    @Published var newItem = TextLimit(limit: 40)
}
