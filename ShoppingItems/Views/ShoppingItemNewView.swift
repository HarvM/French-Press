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
    
    //MARK: - Enum that handles the two images that toggles between the user having or not having the item
    enum CheckMarks: String {
        case checkMarkFilled = "checkCircleFill"
        case checkMarkEmpty = "checkCircleEmpty"
    }
    
    //MARK: - Properties
    var itemToBeAdded: String = ""
    var quantity: Int = 0
    @State var isChecked = false
    
    func toggle() {
        isChecked = !isChecked
    }
    
    //MARK: - View
    var body: some View {
        
        ///Calls the "toggle" func above that differentiates between the two states
        Button(action: toggle)
        {
            HStack {
                ///Alternates between the two images depending on whether checked or not
                Image(isChecked ? CheckMarks.checkMarkFilled.rawValue: CheckMarks.checkMarkEmpty.rawValue)
                    .foregroundColor(.white)
                    .padding(4)
                
                ///Defines the cell dimensions and what's displayed within it
                VStack(alignment: .leading) {
                    Text("\(itemToBeAdded)")
                        .font(Font.system(size: 18, design: .rounded))
                        .frame(height: 55)
                        .padding(10)
                }
            }
        }
    }
}
