//
//  ButtonMenuView.swift
//  Yer Messages
//
//  Created by Marc Harvey on 28/05/2021.
//  Copyright © 2021 Marc Harvey. All rights reserved.
//

import SwiftUI

struct ButtonMenuView: View {
    var body: some View {
        Text("About")
                .frame(width: 200, height: 100, alignment: .center)
                .background(Color.yellow)
                .foregroundColor(Color.red)
    }
}

struct ButtonMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonMenuView()
    }
}
