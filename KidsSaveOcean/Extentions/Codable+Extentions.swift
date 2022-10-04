//
//  Codable+Extentions.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 12/14/21.
//  Copyright © 2021 KidsSaveOcean. All rights reserved.
//

import UIKit

extension Decodable {

    init?(with dictionary: Dictionary<String, Any>?) {

        guard let dictionary = dictionary else {
            assertionFailure("\(Self.self) nil dictionary ")
            return nil
        }

        do {
            let decoder = JSONDecoder()
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            self = try decoder.decode(Self.self, from: data)
        } catch {
            print(error, "\(Self.self) init?(with:Dictionary<String,Any)")
            return nil
        }
    }
}

extension Encodable {
    /**
     Produces a JSON dictionary we can display for debugging or send to the server as a parameter
     */
    var dictionaryRepresentation: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return nil }
        return json
    }

}
