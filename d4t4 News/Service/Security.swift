//
//  Security.swift
//  d4t4 News
//
//  Created by Briteyellow on 25/11/2023.
//

import Foundation
import Security

enum KeychainError: Error {
    case itemAdditionFailed(status: OSStatus)
    case itemRetrievalFailed(status: OSStatus)
    case itemNotFound
    case dataConversionError
}

class Security {
    
    func saveApiKeyToKeychain() throws {
        let key = "apiKey"
        let value = "58e3cf8e35664428a5b127972cb92e9b"
        //710119f4520a4c25b4ab12e46322e7db
        let data = Data(value.utf8)

        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: key,
                                    kSecValueData as String: data]

        SecItemDelete(query as CFDictionary)

        // Add Api Key
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainError.itemAdditionFailed(status: status)
        }
    }
    
    func getApiKeyToKeychain() throws -> String {
        let key = "apiKey"
        
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: key,
                                    kSecReturnData as String: kCFBooleanTrue!,
                                    kSecMatchLimit as String: kSecMatchLimitOne]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }
        guard status == errSecSuccess else {
            throw KeychainError.itemRetrievalFailed(status: status)
        }
        
        guard let data = item as? Data, let result = String(data: data, encoding: .utf8) else {
            throw KeychainError.dataConversionError
        }
        
        return result
    }
}

