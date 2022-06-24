//
//  CheckboxStyle.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 09/11/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import SwiftUI

///Takes the Toggle and fashions it into a check/uncheck mark rather than the default toggle
struct CheckboxStyle: ToggleStyle {
    
    let frameHeight: CGFloat = 26
    let frameWidth: CGFloat = 26
    let fontSize: CGFloat = 20
    let foregroundColourYellow: Color = Color.yellow
    let foregroundColourWhite: Color = Color.white
    
    ///Used in the .toggleStyle in the ShoppingItemNewView to edit the appearance of the toggle
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            configuration.label
            Image(systemName: configuration.isOn ? ContentViewImages.checkmarkFill.rawValue : ContentViewImages.checkmarkEmpty.rawValue)
                .resizable()
                .frame(width: frameWidth, height: frameHeight)
                .foregroundColor(configuration.isOn ? foregroundColourYellow:foregroundColourWhite)
                .font(.system(size: fontSize, weight: .bold, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}
