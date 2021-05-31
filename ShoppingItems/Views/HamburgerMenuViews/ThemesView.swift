//
//  ThemesView.swift
//  Yer Messages
//
//  Created by Marc Harvey on 28/05/2021.
//  Copyright © 2021 Marc Harvey. All rights reserved.
//

import SwiftUI

struct ThemesView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Text("Come see my themes")
        Button("Dismiss Modal"){
            presentationMode.wrappedValue.dismiss()
    }
        .foregroundColor(.black)
    }
}

struct ThemesView_Previews: PreviewProvider {
    static var previews: some View {
        ThemesView()
    }
}
