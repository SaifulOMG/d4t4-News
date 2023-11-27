//
//  PListParser.swift
//  d4t4 News
//
//  Created by Briteyellow on 25/11/2023.
//

import Foundation

struct InfoPlistParser {
    static func getStringValue(forKey key: String) -> String { //get plist string from plist file
        guard let value = Bundle.main.infoDictionary?[key] as? String else {
            fatalError("Could not find value for key \(key) in the info.plist")
        }
        return value
    }
}
