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
        MSAppCenter.start("04281cc3-0793-468b-a77a-ef310ef58b99", withServices:[
          MSAnalytics.self,
          MSCrashes.self
        ])
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}
