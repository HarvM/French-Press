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
            .navigationBarTitle("Themes")
            .foregroundColor(.yellow)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ThemesView_Previews: PreviewProvider {
    static var previews: some View {
        ThemesView()
    }
}
