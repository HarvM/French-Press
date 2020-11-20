//
//  CellView.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 05/01/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import SwiftUI

//This class will deal with the cell creation that will be inserted into the stack in the ContentView class
struct CellView: View {
    
    //MARK: - Properties
    var itemToBeAdded: String = ""
    var quantityOfItem: Int
    @State var isChecked = false
    
    //MARK: - View
    var body: some View {
        VStack {
            HStack {
                ///Have a toggle here followed by the item that the user desires
                Toggle("", isOn: $isChecked).labelsHidden()
                    .padding(-10)
                VStack (alignment: .leading, spacing: 2) {
                    Text("\(itemToBeAdded)")
                        .font(.custom("Merriweather", size: 24, relativeTo: .title))
                        .allowsTightening(true)
                    
                    Text("x \(quantityOfItem)")
                        .font(.custom("Cinzel", size: 18, relativeTo: .title))
                        .lineLimit(1)
                }
                .foregroundColor(.yellow)
                .frame(minWidth: 60, idealWidth: 250, maxWidth: 300, minHeight: 30, idealHeight: 40, maxHeight: 45, alignment: .leading)
                .padding(25)
            }
            .toggleStyle(CheckboxStyle())
        }
    }
}
