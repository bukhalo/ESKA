//
//  ViewController.swift
//  ESKA
//
//  Created by Aleksandr Bukhalo on 14.11.2019.
//  Copyright © 2019 robotmafia. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var ServerInput: NSTextField!
    @IBAction func ServerInputHandler(_ sender: NSTextField) {
    }
    
    
    @IBOutlet weak var UsernameInput: NSTextField!
    @IBAction func UsernameInputHandler(_ sender: NSTextField) {
        print(UsernameInput.stringValue)
    }
    
    @IBOutlet weak var PasswordInput: NSSecureTextField!
    @IBAction func PasswordInputHandler(_ sender: NSSecureTextField) {
        print(PasswordInput.stringValue)
    }
    
    
    @IBAction func ConnectButtonHandler(_ sender: NSButton) {
        let server = ServerInput.stringValue
        let username = UsernameInput.stringValue
        let password = PasswordInput.stringValue
        
        RunCommand.task(launchPath: "/Library/Application Support/Checkpoint/Endpoint Connect/command_line", arguments: ["connect", "-s", server, "-u", username, "-p", password])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

