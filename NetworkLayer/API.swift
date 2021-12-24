//
//  API.swift
//  NetworkLayer
//
//  Created by Q.M.S on 09/11/2021.
//

import Foundation

public struct API {
    
    let baseURL: BaseURL
    let path: [String]
    
    public init(baseURL: BaseURL, path: [String] = []) {
        self.baseURL = baseURL
        self.path = path
    }
    
    var url: URL {
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.port = baseURL.port
        components.path = "/" + path.joined(separator: "/")
        return components.url!
    }
    
}
