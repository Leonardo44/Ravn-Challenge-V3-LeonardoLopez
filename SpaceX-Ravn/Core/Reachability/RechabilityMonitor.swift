//
//  RechabilityMonitor.swift
//  SpaceX-Ravn
//
//  Created by Leo on 1/12/23.
//

import Foundation
import Reachability

class ReachabilityMonitor {
    static let instance = ReachabilityMonitor()
    static let notificationName = "spacex-ravn.ReachabilityMonitor.notification"
    private var reachability: Reachability?
    
    private init() {
        reachability = try! Reachability()

        reachability?.whenReachable = { _ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: ReachabilityMonitor.notificationName), object: nil, userInfo: ["connection":  true])
        }
        
        reachability?.whenUnreachable = { _ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: ReachabilityMonitor.notificationName), object: nil, userInfo: ["connection":  false])
        }
    }
    
    func startListenNotifier() {
        do {
            try reachability?.startNotifier()
        } catch {
            fatalError("Unable to start notifier: \(error.localizedDescription) in class ReachabilityMonitor")
        }
    }
    
    func stopListenNotifier() {
        reachability?.stopNotifier()
    }
}
