//
//  GameScene.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 09/12/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import Foundation
import SpriteKit

///When the user taps on the screen, some boxes will fall from their touch point
class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.location(in: self)
        let box = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 50))
        box.position = location
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        addChild(box)
    }
    
    
}
