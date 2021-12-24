//
//  AppError.swift
//  NetworkLayer
//
//  Created by Q.M.S on 10/11/2021.
//

import Foundation

public enum AppError: Error {
    case unexpected
    case errorMessage(msg: String)
}

extension AppError: LocalizedError {
    
    var description: String {
        switch self {
        case .unexpected:
            return "Something unexpected happened"
        case .errorMessage(let msg):
            return msg
        }
    }
    
}
