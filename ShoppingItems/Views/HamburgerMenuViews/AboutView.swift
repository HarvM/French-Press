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
        NavigationView {
            ZStack {
                Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all)
                VStack {
                    //TODO: Enter in content here
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.black)
                }
            }
            .navigationBarTitle("About")
            .foregroundColor(.yellow)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
//
//struct AboutView_Previews: PreviewProvider {
//    static var previews: some View {
//        AboutView()
//    }
//}
