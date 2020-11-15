//
//  DetailView.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 11/11/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    //MARK: - Properties
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    let itemToBeDisplayed: ShoppingItems
    @State private var hasData = false

   //MARK: - Body of the view
    var body: some View {
        ZStack{
            Color.init(red: 0.07, green: 0.45, blue: 0.87)
                .edgesIgnoringSafeArea(.all)
            Text("\(itemToBeDisplayed.itemToBeAdded) and \(itemToBeDisplayed.notesOnItem)")
                .foregroundColor(.white)
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
////        DetailView()
//    }
//}
