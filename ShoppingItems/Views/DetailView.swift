//
//  DetailView.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 11/11/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import SwiftUI
import SpriteKit

struct DetailView: View {
    
    ///Futura font 
    enum CustomFont: String {
        case defaultFont = "SF Pro"
    }
    
    //MARK: - Properties
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    let itemToBeDisplayed: ShoppingItems
    @State private var hasData = false
    
    //MARK: - Body of the view
    var body: some View {
        ZStack {
            Color("defaultBackground")
                .edgesIgnoringSafeArea(.all)
            NavigationView {
                VStack {
                    Section {
                        Text ("\(itemToBeDisplayed.itemToBeAdded)")
                            .font(.custom(CustomFont.defaultFont.rawValue, size: 35, relativeTo: .headline))
                            .lineLimit(3)
                            .foregroundColor(.yellow)
                            .background(Color("defaultBackground").edgesIgnoringSafeArea(.all))
                    }
                    .frame(minWidth: 200, idealWidth: 350, maxWidth: 400, minHeight: 80, idealHeight: 100, maxHeight: 120, alignment: .top)
                    .background(Color("defaultBackground").edgesIgnoringSafeArea(.all))
                    Section {
                        Text("\(itemToBeDisplayed.notesOnItem)")
                            .foregroundColor(.white)
                            .font(.custom(CustomFont.defaultFont.rawValue, size: 25, relativeTo: .headline))
                            .background(Color("defaultBackground").edgesIgnoringSafeArea(.all))
                        
                    }
                    .background(Color("defaultBackground").edgesIgnoringSafeArea(.all))
                    
                }
                .frame(minWidth: 200, idealWidth: 350, maxWidth: 400, minHeight: 400, idealHeight: 700, maxHeight: 800, alignment: .top)
                .background(Color("defaultBackground").edgesIgnoringSafeArea(.all))
                
            }
            .background(Color("defaultBackground").edgesIgnoringSafeArea(.all))
            .multilineTextAlignment(.center)
            .allowsTightening(true)
            .minimumScaleFactor(0.9)
            .navigationViewStyle(StackNavigationViewStyle()) ///removes iPad split screen
        }
    }    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
