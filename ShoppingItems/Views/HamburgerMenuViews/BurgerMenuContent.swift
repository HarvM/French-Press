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
    var body: some View {
        NavigationView {
            ZStack {
                Color(BackgroundColours.burgerBackground.rawValue).edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    HStack {
                        Image(ContentViewImages.appIcon.rawValue)
                    }
                    .background(Color(BackgroundColours.burgerBackground.rawValue).edgesIgnoringSafeArea(.all))
                    .padding(.top, 30)
                    HStack {
                        NavigationLink (destination: AboutView()) {
                            Text("About")
                                .font(.title2)
                        }
                    }
                    .padding(.top, 80) ///Kicks the first bit off the top
                    HStack {
                        NavigationLink (destination: ThemesView()) {
                            Text("Themes")
                                .font(.title2)
                        }
                    }
                    .padding(.top, 30)
                    HStack {
                        NavigationLink (destination: SupportView()) {
                            Text("Support")
                                .font(.title2)
                        }
                    }
                    .padding(.top, 30)
                    Spacer() ///Kicks the v number to the bottom
                    HStack{
                        Text("v. 2.2.3") //TODO: Sort to release version number when time comes
                            .font(.footnote)
                            .padding(.leading, 10)
                    }
                    .padding(.top, 120)
                } ///End of VStack
                .foregroundColor(.yellow)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
//                .background(Color(BackgroundColours.burgerBackground.rawValue))
//                .edgesIgnoringSafeArea(.all)
            } ///End of View
            .background(Color(BackgroundColours.burgerBackground.rawValue))
        }
        .background(Color(BackgroundColours.burgerBackground.rawValue))
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
