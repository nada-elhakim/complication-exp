//
//  ExtensionDelegate.swift
//  complications WatchKit Extension
//
//  Created by Nada ElHakim on 11/12/19.
//  Copyright © 2019 Nada ElHakim. All rights reserved.
//

import WatchKit
import PushKit
import WatchConnectivity
import UserNotifications

class ExtensionDelegate: NSObject, WKExtensionDelegate, PKPushRegistryDelegate, WCSessionDelegate {
    var complicationRegistry: PKPushRegistry!
    var session : WCSession!

    func applicationDidFinishLaunching() {
        startWCSession()
        registerForComplicationPushes()
    }
    
    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompletedWithSnapshot(false)
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
                // Be sure to complete the relevant-shortcut task once you're done.
                relevantShortcutTask.setTaskCompletedWithSnapshot(false)
            case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
                // Be sure to complete the intent-did-run task once you're done.
                intentDidRunTask.setTaskCompletedWithSnapshot(false)
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }
    
    func didReceiveRemoteNotification(_ userInfo: [AnyHashable : Any]) {
        updateComplication()
    }
    
    func updateComplication() {
        let complicationServer = CLKComplicationServer.sharedInstance()
    
        ComplicationController.counter += 1

        for complication in complicationServer.activeComplications ?? [] {
            complicationServer.reloadTimeline(for: complication)
        }
    }
    
    func registerForComplicationPushes() {
        print("Registering...")
        complicationRegistry = PKPushRegistry(queue: .main)
        complicationRegistry.delegate = self
        complicationRegistry.desiredPushTypes = [.complication]
    }
    
    func startWCSession() {
        if (WCSession.isSupported()) {
            session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        print("Push registration success")
        let deviceTokenString = pushCredentials.token.map { String(format: "%02.2hhx", $0) }.joined()
        print("Push Credentials \(deviceTokenString)")
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        print("Received push")
        updateComplication()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }

    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        updateComplication()
    }
    
    func didReceiveRemoteNotification(_ userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (WKBackgroundFetchResult) -> Void) {
        print("Received push from pushkit")
        updateComplication()
    }
}
