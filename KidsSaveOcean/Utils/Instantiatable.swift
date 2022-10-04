//
//  Instantiatable.swift
//  CheckedItems
//
//  Created by Maria Soboleva on 6/24/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

protocol Instantiatable {
    static func instantiate() -> Self
}

extension Instantiatable where Self: UIViewController {
    
    static func instantiate() -> Self {
        let storyboardId = "\(self)"

        guard let genericViewContoller = UIStoryboard.getGenericViewController(with: storyboardId),
            let gViewController = genericViewContoller as? Self else {
                fatalError("Failed to instantiate '\(storyboardId)'")
        }

       return gViewController
    }
}

extension FileManager {

    private static let enumeratorForAllFiles: FileManager.DirectoryEnumerator? = {
        guard let directory = Bundle.main.resourcePath,
            let enumerator = FileManager.default.enumerator(atPath: directory) else {
                return nil
        }

        return enumerator
    }()

    static let allFiles: Set<String> = {
        var files: Set<String> = Set()
        while let element = enumeratorForAllFiles?.nextObject() as? String {
            files.insert(element)
        }
        return files
    }()

}

extension UIStoryboard {
    
    static let all: [UIStoryboard] = FileManager.allFiles
        .filter { $0.hasSuffix(".storyboardc") }
        .map { URL(fileURLWithPath: $0).deletingPathExtension().lastPathComponent }
        .map { UIStoryboard(name: $0, bundle: nil)}
    
    static var cache: [String: UIStoryboard] = [:]
    
    static func getGenericViewController(with storyboardId: String) -> UIViewController? {

        if let storyboard = cache[storyboardId] {
            return storyboard.instantiateViewController(withIdentifier: storyboardId)
        }

        for storyboard in all {
            guard let gViewController = storyboard.instantiateViewControllerSafe(withIdentifier: storyboardId) else {
                continue
            }
            cache[storyboardId] = storyboard
            return gViewController
        }

       return nil
    }
    
    func instantiateViewControllerSafe(withIdentifier identifier: String) -> UIViewController? {
        if let availableIdentifiers = self.value(forKey: "identifierToNibNameMap") as? [String: Any] {
            if availableIdentifiers[identifier] != nil {
                return self.instantiateViewController(withIdentifier: identifier)
            }
        }
        return nil
    }
    
}
