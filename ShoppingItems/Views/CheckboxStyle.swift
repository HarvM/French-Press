//
//  CheckboxStyle.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 09/11/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import SwiftUI

//Takes the Toggle and fashions it into a check/uncheck mark rather than the default toggle
struct CheckboxStyle: ToggleStyle {
    
    ///Used in the .toggleStyle in the ShoppingItemNewView to edit the appearance of the toggle
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            configuration.label
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 26, height: 26)
                .foregroundColor(configuration.isOn ? .yellow : .white)
                .font(.system(size: 20, weight: .bold, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}
