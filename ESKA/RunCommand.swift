//
//  RunCommand.swift
//  ESKA
//
//  Created by Aleksandr Bukhalo on 16.11.2019.
//  Copyright © 2019 robotmafia. All rights reserved.
//
import Foundation

class RunCommand {
    static func task(launchPath path: String, arguments args: [String]) -> String {
        let task = Process()
        task.launchPath = path
        task.arguments = args
        
        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)
        task.waitUntilExit()
        
        print(path)
        print(args)
        
        return(output!)
    }
}
