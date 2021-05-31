//
//  SupportView.swift
//  Yer Messages
//
//  Created by Marc Harvey on 28/05/2021.
//  Copyright © 2021 Marc Harvey. All rights reserved.
//

import SwiftUI

struct SupportView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Text("Need some help. Here's the support")
        Button("Dismiss Modal"){
            presentationMode.wrappedValue.dismiss()
        }
        .foregroundColor(.black)
    }
}

struct SupportView_Previews: PreviewProvider {
    static var previews: some View {
        SupportView()
    }
}
