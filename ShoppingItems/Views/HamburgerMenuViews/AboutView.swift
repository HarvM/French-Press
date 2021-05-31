//
//  AboutView.swift
//  Yer Messages
//
//  Created by Marc Harvey on 28/05/2021.
//  Copyright © 2021 Marc Harvey. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            Text("Welcome to About")
            Button("Dismiss Modal"){
                presentationMode.wrappedValue.dismiss()
        }
            .foregroundColor(.black)
    }
}
//
//struct AboutView_Previews: PreviewProvider {
//    static var previews: some View {
//        AboutView()
//    }
//}
