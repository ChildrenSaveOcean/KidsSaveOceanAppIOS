//
//  KSOKeyChainUtility.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 3/27/18.
//  Copyright © 2018 Maria Soboleva. All rights reserved.
//

import UIKit

// Arguments for the keychain queries

enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}

/* ----------------------------------------------------------------------------------------------------------*/
/* ------------------------ Security Getting and Saving Data from/to Keychain -------------------------------*/
/* ----------------------------------------------------------------------------------------------------------*/

class KSOKeyChainUtility: NSObject {
    
    let userAccount = "AuthenticatedUser"
    let accessGroup = "SignInModule.com.test.GenericKeyChainShared"
    let userService = "SimCredentialData"
    
    /* ---------------------------------- Get KeyChain Data --------------------------------- */
    class func getKeyChainData() throws -> (username:String?, password:String?) {
        
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrServer as String: AUTORIZATION_URL_AUTHORIZE_DOMAIN,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnAttributes as String: true,
                                    kSecReturnData as String: true]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        
        guard let existingItem = item as? [String : Any],
            let passwordData = existingItem[kSecValueData as String] as? Data,
            let password = String(data: passwordData, encoding: String.Encoding.utf8),
            let account = existingItem[kSecAttrAccount as String] as? String
            else {
                throw KeychainError.unexpectedPasswordData
        }
        return(account, password)
    }
    
    /* ---------------------------------- Set KeyChain Data --------------------------------- */
    class func saveKeyChainData(account:String!, password:String!) throws -> () {
        
        var savedUserCredentials:(username:String?, password:String?)
        do {
            savedUserCredentials = try getKeyChainData()
            if (savedUserCredentials.username! != account || savedUserCredentials.password! != password!) {
                try self.updateKeyChainData(account: account, passwordOrig: password)
            }
        } catch {
            try self.addKeyChainData(account: account, passwordOrig: password)
        }
    }
    
    /* ---------------------------------- Add new KeyChain Data --------------------------------- */
    class func addKeyChainData(account:String!, passwordOrig:String!) throws -> () {
        
        //let account  = Credentials.username
        let password = passwordOrig.data(using: String.Encoding.utf8)! //Credentials.password.data(using: String.Encoding.utf8)!
        
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrAccount as String: account,
                                    kSecAttrServer as String: AUTORIZATION_URL_AUTHORIZE_DOMAIN,
                                    kSecValueData as String: password]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }
    
    /* ---------------------------------- Update KeyChain Data --------------------------------- */
    class func updateKeyChainData(account:String!, passwordOrig:String!) throws -> () {
        
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrServer as String: AUTORIZATION_URL_AUTHORIZE_DOMAIN]
        
        let password = passwordOrig.data(using: String.Encoding.utf8)! //let password = credentials.password.data(using: String.Encoding.utf8)!
        let attributes: [String: Any] = [kSecAttrAccount as String: account,
                                         kSecValueData as String: password]
        // update
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        
    }
    
    /* ---------------------------------- Delete KeyChain Data --------------------------------- */
    class func deleteKeyChainData(account:String!, passwordOrig:String!) throws -> () {
        
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrServer as String: AUTORIZATION_URL_AUTHORIZE_DOMAIN]
        
        // delete
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
    }

}
