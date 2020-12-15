//
//  DetailView.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 11/11/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import SwiftUI
import SpriteKit
import UserNotifications

struct DetailView: View {
    
    ///The Futura font 
    enum CustomFont: String {
        case futuraFont = "Futura"
    }
    
    //MARK: - Properties
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    let itemToBeDisplayed: ShoppingItems
    @State public var notesEmpty = false
    @State var displayGame = false
    
    ///Setting up the GameScene
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 300, height: 300)
        scene.scaleMode = .fill
        return scene
    }
    
    //MARK: - Body of the view
    var body: some View {
        NavigationView {
            ZStack{
//                SpriteView(scene: scene)
//                    .frame(width: 300, height: 300, alignment: .center)
//                    .edgesIgnoringSafeArea(.all)
//                    .zIndex(3)
//                    .background(Color(.clear))
//                    .onAppear(perform: startFidgetGame)
                Color("defaultBackground")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Section {
                    Text ("\(itemToBeDisplayed.itemToBeAdded)")
                        .font(.custom(CustomFont.futuraFont.rawValue, size: 35, relativeTo: .headline))
                        .lineLimit(3)
                        .foregroundColor(.yellow)
                    }
                    .frame(minWidth: 200, idealWidth: 350, maxWidth: 400, minHeight: 80, idealHeight: 100, maxHeight: 120, alignment: .top)
                    Section {
                    Text("\(itemToBeDisplayed.notesOnItem)")
                        .foregroundColor(.white)
                        .font(.custom(CustomFont.futuraFont.rawValue, size: 25, relativeTo: .headline))
                    }
                    .frame(minWidth: 200, idealWidth: 350, maxWidth: 400, minHeight: 400, idealHeight: 700, maxHeight: 800, alignment: .center)
                }
                .multilineTextAlignment(.center)
                .allowsTightening(true)
                .minimumScaleFactor(0.9)
                .padding(.top, 20)
            }
        }
    }
    
//    private func startFidgetGame() {
//        if itemToBeDisplayed.notesOnItem == "" {
//
//        } else {
//         print("Hello there")
//        }
//    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Henlo")
    }
}
