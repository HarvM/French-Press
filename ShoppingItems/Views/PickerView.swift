////
////  PickerView.swift
////  ShoppingItems
////
////  Created by Marc Harvey on 27/11/2020.
////  Copyright © 2020 Marc Harvey. All rights reserved.
////
//
//import SwiftUI
//
//struct PickerView: View {
//    @State var selectedMeasurement = 0
//    let measurementFound = ["pack", "litre", "pint/s", "gram", "kilogram", "millilitre", "wee bag/s", "tin/s", "bottle/s", "jar/s", "bunch/es", "box/es", "crate/s", "keg/s", "tub/s", "punnet/s"]
//    var body: some View {
//        Picker(selection: $selectedMeasurement, label: Text("").background(Color("defaultBackground"))) {
//            ForEach(0 ..< measurementFound.count) {
//                Text(self.measurementFound[$0])
//                    .frame(height: 40)
//            }
//            .font(.custom(CustomFontDetailView.futuraFont.rawValue, size: 14, relativeTo: .headline))
//            
//        }
//        .pickerStyle(DefaultPickerStyle())
//    }
//}
//
//struct PickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PickerView()
//    }
//}
