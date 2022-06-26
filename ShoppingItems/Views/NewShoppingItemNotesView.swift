//
//  NewShoppingItemNotesView.swift
//  Yer Messages
//
//  Created by Marc Harvey on 26/06/2022.
//  Copyright © 2022 Marc Harvey. All rights reserved.
//

import SwiftUI

struct NewShoppingItemNotesView: View {
    
    let stringStore = StringStore()
    @ObservedObject var newShoppingItemNote: ItemNote
    
    var body: some View {
        TextField(stringStore.typeHere, text: $newShoppingItemNote.notesOnItem.text)
            .frame(height: 50)
            .multilineTextAlignment(.leading)
            .font(.custom(DefaultFont.defaultFont.rawValue, size: 16, relativeTo: .headline))
            .ignoresSafeArea(.keyboard, edges: .bottom)
        Spacer()
        /// Will display the number of characters already typed and the limit
        Text("\(newShoppingItemNote.notesOnItem.text.count)|40")
            .font(.custom(DefaultFont.defaultFont.rawValue, size: 16, relativeTo: .headline))
            .foregroundColor(.gray)
    }
}

//struct NewShoppingItemNotesView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewShoppingItemNotesView()
//    }
//}

class ItemNote: ObservableObject {
    @Published var notesOnItem = TextLimit(limit: 40)
}
