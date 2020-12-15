//
//  GameView.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 12/12/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import SwiftUI
import SpriteKit

//This struct will give the view that will be fed into the DetailView should the "itemToBeDisplayed.notesOnItem" be empty
struct GameView: UIViewRepresentable {
    
    ///Creates the view
    func makeUIView(context: UIViewRepresentableContext<GameView>) -> SKView {
        
        let view = SKView()
        view.allowsTransparency = true
         
        if let scene = GameScene(fileNamed: "GameScene") {
            scene.backgroundColor = UIColor.clear
            view.presentScene(scene)
        }
        return view
    }
    
    func updateUIView(_ uiView: SKView, context: UIViewRepresentableContext<GameView>) {
        print("Nothing right now")
    }
    
}


