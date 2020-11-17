//
//  ShoppingItemNewView.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 05/01/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import SwiftUI

//This class will deal with the cell creation that will be inserted into the stack in the ContentView class
struct ShoppingItemNewView: View {
    
    //MARK: - Properties
    var itemToBeAdded: String = ""
    var quantityOfItem: Int = 0
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
                        .font(Font.system(size: 20, design: .rounded))
                        .foregroundColor(.yellow)
                        .frame(height: 40)
                        .lineLimit(1)
                        .allowsTightening(true)
                    
                    Text("Quantity: \(quantityOfItem)")
                        .font(Font.system(size: 20, design: .rounded))
                        .foregroundColor(.yellow)
                        .frame(height: 40)
                        .lineLimit(1)
                        
                }
                .padding(15)
            }
            .toggleStyle(CheckboxStyle())
        }
    }
}
