//
//  d4t4_NewsApp.swift
//  d4t4 News
//
//  Created by Briteyellow on 25/11/2023.
//

import SwiftUI

@main
struct d4t4_NewsApp: App {
    init() {
        do {
            try Security().saveApiKeyToKeychain()
        } catch {
            print("Failed to save API key: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            SearchView()
        }
    }
}
