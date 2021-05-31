//
//  HamburgerMenuView.swift
//  Yer Messages
//
//  Created by Marc Harvey on 19/05/2021.
//  Copyright © 2021 Marc Harvey. All rights reserved.
//

import SwiftUI

///View that will handle how the hamburger menu is displayed
struct BurgerMenuContent: View {
    @State private var isAboutPresented = false
    @State private var isThemesPresented = false
    @State private var isSupportPresented = false
    var body: some View {
        NavigationView {
        ZStack {
                Color(BackgroundColours.burgerBackground.rawValue).edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    HStack {
                        Image(ContentViewImages.appIcon.rawValue)
                    }
                    HStack {
                        Button("About") {
                            isAboutPresented.toggle()
                               }
                        .font(.title2)
                               .fullScreenCover(isPresented: $isAboutPresented, content: AboutView.init)
                    }
                    .background(Color(BackgroundColours.burgerBackground.rawValue).edgesIgnoringSafeArea(.all))
                    .padding(.top, 30)
                    HStack {
                        Button("Themes") {
                                   isThemesPresented.toggle()
                               }
                        .font(.title2)
                               .fullScreenCover(isPresented: $isThemesPresented, content: ThemesView.init)
                    }
                    .padding(.top, 30)
                    HStack {
                        Button("Support") {
                                   isSupportPresented.toggle()
                               }
                        .font(.title2)
                               .fullScreenCover(isPresented: $isSupportPresented, content: SupportView.init)
                    }
                    .padding(.top, 30)
                    Spacer() ///Kicks the v number to the bottom
                    HStack{
                        Text("v. 2.2.3") //TODO: Sort to release version number when time comes
                            .font(.footnote)
                            .padding(.leading, 10)
                    }
                    .padding(.top, 120)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
        }
        }
    }
    
    public func moveToSomewhere() {
        
        print("Trying to move across")
        
    }
}

struct HamburgerMenuView_Previews: PreviewProvider {
    static var previews: some View {
        BurgerMenuContent()
    }
}
