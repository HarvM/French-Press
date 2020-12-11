//
//  WatchConnectivityProvider.swift
//  ShoppingItems
//
//  Created by Marc Harvey on 10/12/2020.
//  Copyright © 2020 Marc Harvey. All rights reserved.
//

import Foundation

///The class that will deal with the communication between the watch and the phone
final class WatchConnectivityProvider: NSObject, WCSessionDelegate {
    //MARK: Properties (Need the NSPersistentContainer to access CoreData
    private let persistentContainer: NSPersistentContainer
    private let session: WCSession

    init(session: WCSession = .default, persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        self.session = session
        super.init()
        session.delegate = self
    }

    func connect() {
        guard let WCSession.isSupported else {
            os_log(.debug, log: .watch, "watch session isn't happening")
            return
        }
        os_log(.debug, log: .watch, "activating watch session")
        session.activate()
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionState, error: Error?) {
        os_log(.debug, log: .watch, "did finish activating session %lu (error: %s)",
               activationState == .activated,
               error?.localizedDescription ?? "none") )
    }
