//
//  EndpointProvider.swift
//  NetworkLayer
//
//  Created by Q.M.S on 09/11/2021.
//

import Foundation

public protocol EndpointProvider {
    
    associatedtype Response: DTO
    associatedtype Body: DTO
    associatedtype Failure: DTO
    associatedtype Query: DTO
    
    var endpoint: Endpoint<Body, Query> { get }
}
