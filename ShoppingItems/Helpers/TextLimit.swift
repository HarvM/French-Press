//
//  TextLimit.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 26/10/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import Foundation

class TextLimit: ObservableObject {
    
    ///Ensures that the user's TextField entry cannot exceed the character limit which is further defined in the SaveView for each of the different TextFields
    @Published var number: Int = 0
    @Published var text = "" {
        didSet {
            if text.count > characterLimit && oldValue.count <= characterLimit {
                text = oldValue
            }
        }
    }
    let characterLimit: Int
    init(limit: Int = 100){
        characterLimit = limit
    }
}
