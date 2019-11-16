//
//  ViewController.swift
//  ESKA
//
//  Created by Aleksandr Bukhalo on 14.11.2019.
//  Copyright © 2019 robotmafia. All rights reserved.
//

import Cocoa
import KeychainAccess

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
        
        let keychain: Keychain
        let service = sitename
        if (!sitename.isEmpty) {
            keychain = Keychain(service: service)
        } else {
            keychain = Keychain()
        }
        keychain[username] = password
        
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
        let keychain: Keychain
        keychain = Keychain(service: connectionNames[0])
        var key: String = ""
        let items = keychain.allItems()
        for item in items {
            if (item["service"] as! String == connectionNames[0]) {
                key = item["key"] as! String
            }
        }
        
        let token = keychain[key]
        UsernameInput.stringValue = key
        PasswordInput.stringValue = token as! String
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

