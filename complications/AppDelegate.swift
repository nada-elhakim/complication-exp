//
//  AppDelegate.swift
//  complications
//
//  Created by Nada ElHakim on 11/12/19.
//  Copyright © 2019 Nada ElHakim. All rights reserved.
//

import UIKit
import PushKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PKPushRegistryDelegate {
    var complicationRegistry: PKPushRegistry!
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registerForComplicationPushes()
        return true
    }
    
    func registerForComplicationPushes() {
        print("Registering...")
        complicationRegistry = PKPushRegistry(queue: .main)
        complicationRegistry.delegate = self
        complicationRegistry.desiredPushTypes = [.complication]
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        let deviceTokenString = pushCredentials.token.map { String(format: "%02.2hhx", $0) }.joined()
        print("deviceTokenString \(deviceTokenString)")
    }

    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        print("Received push")
    }
}

