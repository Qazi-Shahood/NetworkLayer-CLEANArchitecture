//
//  NetworkResult.swift
//  NetworkLayer
//
//  Created by Q.M.S on 09/11/2021.
//

import Foundation

public enum NetworkResult<V, W, E: Error> {
    case success(V)
    case failure(W)
    case error(E)
}
