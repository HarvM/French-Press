//
//  AboutView.swift
//  Yer Messages
//
//  Created by Marc Harvey on 28/05/2021.
//  Copyright © 2021 Marc Harvey. All rights reserved.
//

import SwiftUI
import StoreKit

struct AboutView: View {
    
    ///Needed when using modal to dismiss view
    @Environment(\.presentationMode) var presentationMode
    ///To open the URL
    @Environment(\.openURL) var openURL
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all)
                //MARK: - Main
                VStack {
                    //TODO: A brief about
                    HStack {
                        Text("Thanks for giving this a try and I hope it makes your shopping a little easier.")
                    }
                    .padding()
                    HStack {
                        Text("If you have suggestions or want to give some feedback then please feel free to contact me on Twitter.")
                    }
                    .padding()
                    Button(action: {
                        openURL(URL(string: "https://twitter.com/MessagesYer")!)
                    }) {
                        Image(ContentViewImages.twitterIcon.rawValue)
                    }
                } ///End of VStack
            } ///End of ZStack
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.black)
                }
            } ///End of toolbar
            .navigationBarTitle("About")
            .foregroundColor(.yellow)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
