//
//  HamburgerMenuView.swift
//  Yer Messages
//
//  Created by Marc Harvey on 19/05/2021.
//  Copyright © 2021 Marc Harvey. All rights reserved.
//

import SwiftUI

/// View that will handle how the hamburger menu is displayed
struct BurgerMenuContent: View {
    
    @State private var isAboutPresented = false
    @State private var isThemesPresented = false
    
    /// Changes the navigationBar background colour to what I want
    init() {
//    UINavigationBar.appearance().backgroundColor = UIColor(Color(BackgroundColours.burgerBackground.rawValue))
    }
    
    //MARK: - Body of the View
    var body: some View {
        NavigationView {
            ZStack {
                Color(BackgroundColours.defaultBackground.rawValue).edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    /// App icon that starts the menu
                    HStack {
                        Image(ContentViewImages.appIcon.rawValue)
                    } /// End of HStack
                    .padding()
                    // MARK: - "About" section that will give some more details about the app and where support can be found
                    HStack {
                        Button("About") {
                            isAboutPresented.toggle()
                        }
                        .font(.title2)
                        .fullScreenCover(isPresented: $isAboutPresented,
                                         content: AboutView.init)
                    } /// End of HStack
                    .padding()
                    // MARK:  - "Themes" section
                    HStack {
                        Button("Themes") {
                            isThemesPresented.toggle()
                        }
                        .font(.title2)
                        .fullScreenCover(isPresented: $isThemesPresented,
                                         content: ThemesView.init)
                    } /// End of HStack
                    .padding()
                    Spacer() /// Kicks the v number to the bottom
                    HStack{
                        Text("v. 2.2.3") // TODO: Sort to release version number when time comes
                            .font(.footnote)
                            .foregroundColor(.yellow)
                    } /// End of HStack
                    .padding()
                } /// End of VStack
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
            } /// End of VStack
        }
    }
}

struct HamburgerMenuView_Previews: PreviewProvider {
    static var previews: some View {
        BurgerMenuContent()
    }
}
