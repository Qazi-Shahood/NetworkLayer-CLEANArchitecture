//
//  Endpoint.swift
//  NetworkLayer
//
//  Created by Q.M.S on 09/11/2021.
//

import Foundation

public struct Endpoint<Body: DTO, Query: DTO> {
    private let method: HTTPMethod
    private let path: [String]
    private let query: Query?
    private let timeout: TimeInterval?
    private let headers: [String: String]?
    private let body: Body?
    private let api: API
    
    public init(api: API,
                method: HTTPMethod,
                path: [String],
                query: Query? = nil,
                timeout: TimeInterval? = nil,
                headers: [String: String]? = nil,
                body: Body? = nil) {
        
        self.api = api
        self.method = method
        self.query = query
        self.timeout = timeout
        self.headers = headers
        self.body = body
        self.path = path
    }
    
    private var url: URL {
        var components = URLComponents()
        components.scheme = api.baseURL.scheme
        components.host = api.baseURL.host
        components.port = api.baseURL.port
        components.path = "/" + (api.path + self.path).joined(separator: "/")
        if query != nil {
            components.queryItems = try? query!.toDictionary().map { URLQueryItem(name: $0, value: "\($1)") }
        }
        return components.url!
    }
    
    func urlRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()
        
        if let headers = headers {
            headers.forEach { request.addValue($0, forHTTPHeaderField: $1) }
        }
        
        if let body = body {
            request.allHTTPHeaderFields?["Content-Type"] = "application/json"
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(body)
        }
        
        if let timeout = timeout {
            request.timeoutInterval = timeout
        }
        
        return request
    }
    
}
