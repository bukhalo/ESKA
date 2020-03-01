//
//  AppDelegate.swift
//  ESKA
//
//  Created by Aleksandr Bukhalo on 14.11.2019.
//  Copyright © 2019 robotmafia. All rights reserved.
//

import Cocoa
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        MSAppCenter.start("90741bb7-d103-4003-9a58-f985fa9dac5b", withServices:[
          MSAnalytics.self,
          MSCrashes.self
        ])
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}
