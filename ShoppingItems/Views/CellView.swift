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
    var selectedMeasurement: Int
    var quantitySelected: String = ""
    @State var isChecked = false
    
    //MARK: - View
    var body: some View {
        VStack {
            HStack {
                ///Have a toggle here followed by the item that the user desires
                Toggle("", isOn: $isChecked).labelsHidden()
                    .padding(-8)
                VStack (alignment: .leading, spacing: 2) {
                    Text("\(itemToBeAdded)")
                        .font(.custom("Futura", size: 24, relativeTo: .title))
                        .allowsTightening(true)
                        .clipped()
                    Text("\(quantitySelected)\(selectedMeasurement)")
                        .font(.custom("Futura", size: 18, relativeTo: .title))
                        .lineLimit(1)
                }
                .foregroundColor(.yellow)
                .frame(minWidth: 300, idealWidth: 400, maxWidth: 450, minHeight: 80, idealHeight: 85, maxHeight: 95, alignment: .leading)
                .padding(15)
            }
            .toggleStyle(CheckboxStyle())
        }
    }
}
