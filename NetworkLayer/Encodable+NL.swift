//
//  Encodable+NL.swift
//  NetworkLayer
//
//  Created by Q.M.S on 09/11/2021.
//

import Foundation

extension Encodable {
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }
}
