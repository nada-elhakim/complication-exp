//
//  ViewController.swift
//  complications
//
//  Created by Nada ElHakim on 11/12/19.
//  Copyright © 2019 Nada ElHakim. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    var session: WCSession!
    let userDefaults = UserDefaults.standard
    
    @IBAction func updateComplication(_ sender: Any) {
        // update complication
        if session.isWatchAppInstalled {
            print("Remaining session transfers: \(session.remainingComplicationUserInfoTransfers)")
            let update = userDefaults.integer(forKey: "update")
            userDefaults.set(update + 1, forKey: "update")
            
            session.transferCurrentComplicationUserInfo(["update": update])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if (WCSession.isSupported()) {
            session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
}


