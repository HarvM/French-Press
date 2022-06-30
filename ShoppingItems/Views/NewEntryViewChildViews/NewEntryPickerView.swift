//
//  NewEntryPickerView.swift
//  Yer Messages
//
//  Created by Marc Harvey on 30/06/2022.
//  Copyright © 2022 Marc Harvey. All rights reserved.
//

import SwiftUI

struct NewEntryPickerView: View {
    
    let stringStore = StringStore()
    @ObservedObject var newSelectedMeasurement: ItemMeasurement
    
    var body: some View {
        Picker(selection: $newSelectedMeasurement.newItemMeasurement, label: Text("")) {
            ForEach(0 ..< stringStore.measurementFound.count) {
                Text(self.stringStore.measurementFound[$0])
                    .frame(height: 40)
            }
            .font(.custom(DefaultFont.defaultFont.rawValue, size: 16, relativeTo: .headline))
        }
        .pickerStyle(DefaultPickerStyle())
        .foregroundColor(.red)
    }
}

//struct NewEntryPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewEntryPickerView()
//    }
//}

class ItemMeasurement: ObservableObject {
    @Published var newItemMeasurement = 0
}
