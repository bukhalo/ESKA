//
//  ViewController.swift
//  ESKA
//
//  Created by Aleksandr Bukhalo on 14.11.2019.
//  Copyright © 2019 robotmafia. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    let endpoint = EndpointSecurity()
    
    @IBOutlet weak var SitenameSelect: NSPopUpButton!
    
    
    @IBOutlet weak var UsernameInput: NSTextField!
    @IBAction func UsernameInputHandler(_ sender: NSTextField) {
        print(UsernameInput.stringValue)
    }
    
    @IBOutlet weak var PasswordInput: NSSecureTextField!
    @IBAction func PasswordInputHandler(_ sender: NSSecureTextField) {
        print(PasswordInput.stringValue)
    }
    
    
    @IBOutlet weak var ConnectButton: NSButton!
    @IBAction func ConnectButtonHandler(_ sender: NSButton) {
        let sitename = endpoint.connections[SitenameSelect.indexOfSelectedItem].name
        let username = UsernameInput.stringValue
        let password = PasswordInput.stringValue
        
        print(endpoint.isConnected)
        
        if (!endpoint.isConnected) {
            endpoint.connect(sitename: sitename, username: username, password: password)
            SitenameSelect.isEnabled = false
            UsernameInput.isEnabled = false
            PasswordInput.isEnabled = false
            ConnectButton.title = "Disconnect"
        } else {
            endpoint.disconnect()
            SitenameSelect.isEnabled = true
            UsernameInput.isEnabled = true
            PasswordInput.isEnabled = true
            ConnectButton.title = "Connect"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var connectionNames: [String] = []
        for connection in endpoint.connections {
            connectionNames.append(connection.name)
        }
        SitenameSelect.addItems(withTitles: connectionNames)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear() {
        if (endpoint.isConnected) {
            SitenameSelect.isEnabled = false
            UsernameInput.isEnabled = false
            PasswordInput.isEnabled = false
            ConnectButton.title = "Disconnect"
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

