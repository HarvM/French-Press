//
//  HamburgerMenu.swift
//  Yer Messages
//
//  Created by Marc Harvey on 19/05/2021.
//  Copyright © 2021 Marc Harvey. All rights reserved.
//

import SwiftUI

struct HamburgerMenu: View {
    let width: CGFloat
    let isOpen: Bool
    let menuClose: () -> Void
    
    //MARK: Body
        var body: some View {
            ZStack {
                GeometryReader { _ in
                    EmptyView()
                }
                .background(Color.gray.opacity(0.3))
                .opacity(self.isOpen ? 1.0 : 0.0)
                .animation(Animation.easeIn.delay(0.25))
                .onTapGesture {
                    self.menuClose()
                }
                
                HStack {
                    ///Places the content inside this view
                    BurgerMenuContent()
                        .frame(width: self.width)
                        .background(Color.white)
                        .offset(x: self.isOpen ? 0 : -self.width)
                        .animation(.easeIn)
                    Spacer()
                }
            }
        }
    }
//struct HamburgerMenu_Previews: PreviewProvider {
//    static var previews: some View {
////        HamburgerMenu()
//    }

