//
//  InterfaceController.swift
//  complications WatchKit Extension
//
//  Created by Nada ElHakim on 11/12/19.
//  Copyright © 2019 Nada ElHakim. All rights reserved.
//


import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    var session : WCSession!
    let userDefaults = UserDefaults.standard
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if (WCSession.isSupported()) {
            session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print("Session: Received user info")
        let update = userDefaults.integer(forKey: "update")
        userDefaults.set(update + 1, forKey: "update")
        reloadComplication()
    }
    
    func reloadComplication() {
        print("Reloading complication")
        
        let server = CLKComplicationServer.sharedInstance()
        guard let complications = server.activeComplications, complications.count > 0 else {
            return
        }
        
        for complication in complications  {
            server.reloadTimeline(for: complication)
        }
    }
}
