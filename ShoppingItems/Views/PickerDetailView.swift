//
//  PickerDetailView.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 18/10/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import SwiftUI

//View that will let the user select the amount of the item they want and also add any notes that they need
struct PickerDetailView: View {
    
    //MARK: - Properties
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    //    @ObservedObject var numberOfItem: Int = 0
    @State private var isShowingContentView = false
    let quantityOfItem = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14"]
    @State private var selection = 0
    
    //MARK: - Body the UI that will have a Picker at the top and then a
    var body: some View {
        Form {
            Section {
                Picker(selection: $selection, label: Text("How many?")) {
                    ForEach(0 ..< quantityOfItem.count) {
                        Text(self.quantityOfItem[$0])
                            .navigationBarTitle("How many?")
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }
        }
    }
}

struct PickerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PickerDetailView()
    }
}
