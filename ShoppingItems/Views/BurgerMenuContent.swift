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
        VStack(alignment: .leading) {
            HStack {
                Text("About")
                    .font(.headline)
            }
            .padding(.top, 80) ///Kicks the first bit off the top
            HStack {
                Text("Themes")
                    .font(.headline)
            }
            .padding(.top, 30)
            HStack {
                Text("Support")
                    .font(.headline)
            }
            .padding(.top, 30)
            HStack{
                Text("v. 2.2.3") //TODO: Sort to release version number when time comes
                    .font(.headline)
            }
            .padding(.top, 120)
            Spacer()
        } ///End of VStack
        .padding()
//        .frame(maxWidth: .infinity, alignment: .leading)
//        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
//                   .edgesIgnoringSafeArea(.all)
    } ///End of View
}

struct HamburgerMenuView_Previews: PreviewProvider {
    static var previews: some View {
        BurgerMenuContent()
    }
}
