//
//  EndpointPaths.swift
//  NetworkLayer
//
//  Created by Q.M.S on 10/11/2021.
//

import Foundation

public enum EndpointPaths {
    
    case getTeams
    
    func getPath() -> [String] {
        switch self {
        case .getTeams:
            return ["data", "v1", "teams"]
        }
    }
    
}
