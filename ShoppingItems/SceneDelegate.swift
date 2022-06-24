//
//  SceneDelegate.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 05/01/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        // Create the SwiftUI view and set the context as the value for the managedObjectContext environment keyPath.
        // Add `@Environment(\.managedObjectContext)` in the views that will need the context.
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            // Different in SwiftUI
            // Puts the obejcts into the stack
            let managedObject = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            // Will set the content view that becomes the rootView below into
            // Takes the managedObject from above and then passes it into the ContentView
            let contentView =  ContentView().environment(\.managedObjectContext, managedObject)
            
            // Removes the selected cell being highlighted after the DetailView has been accessed and then returned from
            UITableView.appearance().allowsSelection = false
            UITableViewCell.appearance().selectionStyle = .none
            UIPickerView.appearance().backgroundColor = UIColor(Color("defaultBackground"))
            
            // NOTE: May have to change contentView here later
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            
            /// Changes the navigationBarItem on the DetailView and NewEntryView to white
            window.tintColor = .white
            window.makeKeyAndVisible()
            
            window.rootViewController?.view.backgroundColor = UIColor(Color("defaultBackground"))
            window.inputViewController?.view.backgroundColor =
                UIColor(Color("defaultBackground"))
            
        }
        
        // This ensure that any touch outside of the textField will hide the keyboard
        // Initally had an issue with the placement but sorted that by placing it below the above where it addresses the window
        let tapGesture = MultiGestureRecogniser(target: window, action:#selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window!.addGestureRecognizer(tapGesture)
        print("Trying to detect the gestures")
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
}

extension SceneDelegate: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


