//
//  Reachability.swift
//  InterViewProject
//
//  Created by Abdullah Okudan on 23.03.2022.
//

import Foundation

/*
pod 'ReachabilitySwift'
import Reachability

class NetworkReachability {

   private let internetReachability : Reachability?
   var isReachable : Bool = false

   init() {

       self.internetReachability = try? Reachability.init()
       do{
           try self.internetReachability?.startNotifier()
           NotificationCenter.default.addObserver(self, selector: #selector(self.handleNetworkChange), name: .reachabilityChanged, object: internetReachability)
       }
       catch {
        print("could not start reachability notifier")
       }
   }

   @objc private func handleNetworkChange(notify: Notification) {

       let reachability = notify.object as! Reachability
       if reachability.connection != .unavailable {
           self.isReachable = true
       }
       else {
           self.isReachable = false
       }
       print("Internet Connected : \(self.isReachable)") //Print Status of Network Connection
   }
}
*/
