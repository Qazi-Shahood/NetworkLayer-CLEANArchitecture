//
//  NetworkError.swift
//  NetworkLayer
//
//  Created by Q.M.S on 09/11/2021.
//

import Foundation

public enum NetworkError: Error {
    case requestCreation
    case decoding(Error)
    case server(Error)
    
    var description: String {
        
        #if DEBUG
        switch self {
        case .requestCreation:
            return "Request creation error"
        case .decoding(let error):
            return (error as? DecodingError).debugDescription
        case .server(let error):
            return error.localizedDescription
        }
        #else
        switch self {
        case .requestCreation:
            return "Request creation error"
        case .decoding(let error), .server(let error):
            return error.localizedDescription
        }
        #endif
        
    }
}
