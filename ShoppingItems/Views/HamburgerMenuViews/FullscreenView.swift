//
//  FullscreenView.swift
//  Yer Messages
//
//  Created by Marc Harvey on 31/05/2021.
//  Copyright © 2021 Marc Harvey. All rights reserved.
//

import SwiftUI

struct FullscreenView: View {
    @Environment(\.presentationMode) var presentationMode

       var body: some View {
           Button("Dismiss Modal"){
               presentationMode.wrappedValue.dismiss()
           }
           .background(Color.black)
       }
}

struct FullscreenView_Previews: PreviewProvider {
    static var previews: some View {
        FullscreenView()
    }
}
