//
//  EndpointSecurity.swift
//  ESKA
//
//  Created by Aleksandr Bukhalo on 16.11.2019.
//  Copyright © 2019 robotmafia. All rights reserved.
//

import Foundation

class EndpointSecurity {
    private let path: String = "/Library/Application Support/Checkpoint/Endpoint Connect/command_line"
    struct Connection {
        var name: String
        var gateway: String
        var status: String
        var isActive: Bool
        var firewallPolicy: String?
        var authenticationMethod: String
    }
    var connections: [Connection] = []
    var isConnected: Bool = false
    var connectionsRaw: String = ""
    
    init() {
        self.info()
        self.parseConnectionsRaw()
    }
    
    private func getName(connectionInfoRaw: String) -> String {
        let step1 = connectionInfoRaw.components(separatedBy: "\n\t") // split strings
        let step2 = step1[0] // get first string with connection name
        let step3 = step2.trimmingCharacters(in: .whitespacesAndNewlines) // remove spaces from string
        return String(step3.dropLast()) // remove last character ":" from string
    }
    
    func parseConnectionsRaw() {
        var connections = self.connectionsRaw.components(separatedBy: "Conn ")
        let connection = connections[1]
        let tset: [String] = connection.components(separatedBy: "\n\t")
        
        let name: String = getName(connectionInfoRaw: connection)
        var gateway: String = ""
        var status: String = ""
        var isActive: Bool = false
        var firewallPolicy: String = ""
        var authenticationMethod: String = ""
        
        for item in tset {
            let valueKey = item.components(separatedBy: ": ")
            switch valueKey[0] {
            case "gw":
                gateway = valueKey[1]
            case "status":
                status = valueKey[1]
                // Check connected or not
                if (valueKey[1] == "Connected") {
                    self.isConnected = true
                } else {
                    self.isConnected = false
                }
            case "active site":
                isActive = NSString(string: valueKey[1]).boolValue
            case "firewall policy":
                firewallPolicy = valueKey[1]
            case "authentication method":
                authenticationMethod = valueKey[1]
            default:
                break
            }
        }
        let conn = Connection(name: name, gateway: gateway, status: status, isActive: isActive, firewallPolicy: firewallPolicy, authenticationMethod: authenticationMethod)
        self.connections.append(conn)
    }
    
    func info() {
        self.connectionsRaw = RunCommand.task(launchPath: self.path, arguments: ["info"])
    }
    
    func connect(sitename: String, username: String, password: String) {
        RunCommand.task(launchPath: self.path, arguments: ["connect", "-s", sitename, "-u", username, "-p", password])
        self.isConnected = true
    }
    
    func disconnect() {
        RunCommand.task(launchPath: self.path, arguments: ["disconnect"])
        self.isConnected = false
    }
}
