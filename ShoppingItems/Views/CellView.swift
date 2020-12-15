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
    var quantitySelected: String = ""
    var preferredMeasurement: String = ""
    @State var finalOutput = ""
    var multipleItems: String = "s"
    @State var isChecked = false
    @State var moreThanOne = false
    
    //MARK: - View
    var body: some View {
        VStack {
            HStack {
                ///Have a toggle here followed by the item that the user desires
                Toggle("", isOn: $isChecked).labelsHidden()
                    .padding(-8)
                VStack (alignment: .leading, spacing: 2) {
                    ///Header: name of the item the user has selected
                    Text("\(itemToBeAdded)")
                        .font(.custom("Futura", size: 24, relativeTo: .title))
                        .allowsTightening(true)
                        .clipped()
                    ///Notes on the item that has been selected
                    Text("\(quantitySelected) \(preferredMeasurement)\(finalOutput)")
                        .font(.custom("Futura", size: 18, relativeTo: .title))
                        .lineLimit(1)
                        .textCase(.lowercase)
                }
                .foregroundColor(.yellow)
                .frame(minWidth: 300, idealWidth: 400, maxWidth: 450, minHeight: 80, idealHeight: 85, maxHeight: 95, alignment: .leading)
                .padding(15)
                .onAppear(perform: singleOrMultiple)
            }
            .toggleStyle(CheckboxStyle())
        }
    }
    //MARK: - Func for single/multiple items
     private func singleOrMultiple() {
        ///I feel like there's a better way to do this but this is how I got it working
        ///Will look into changing the quantity at the NewEntryView to a float to allow a range between 0 and 1.9 instead
        ///Finally seen that it was worth using a @State instead for the finalOutput
        if quantitySelected == "1" {
        } else {
            finalOutput = self.multipleItems
        }
    }
}