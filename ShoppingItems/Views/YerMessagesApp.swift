//
//  YerMessagesApp.swift
//  Yer Messages
//
//  Created by Marc Harvey on 07/07/2023.
//  Copyright © 2023 Marc Harvey. All rights reserved.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct YerMessagesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: ShoppingItems.self)
        }
    }
}

//#Preview {
//    YerMessagesApp()
//}
