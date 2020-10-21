//
//  MultiGestureRecogniser.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 14/04/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import Foundation
import UIKit

//Class will deal with handling the gestures
//Will change the state depending on the gesture
//Stops the hiding when switching from one textField to another
//Changes to .ended state when touches have stopped
//Changes to .cancelled state when the touches have been cancelled
class MultiGestureRecogniser: UIGestureRecognizer {
    
    //Prevents the keyboard hide from firing when switching from one textField to another
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if let textField = touches.first?.view, textField is UITextField {
            state = .failed
        } else {
            state = .began
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .ended
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .cancelled
    }
}
