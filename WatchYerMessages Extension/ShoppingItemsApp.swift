//
//  ShoppingItemsApp.swift
//  WatchYerMessages Extension
//
//  Created by Marc Harvey on 11/12/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import SwiftUI

@main
struct ShoppingItemsApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
