//
//  HTTPHeaders+NL.swift
//  NetworkLayer
//
//  Created by Q.M.S on 09/11/2021.
//

import Foundation

extension HTTPHeaders {
    static var defaultHeaders: Self {
        return [:]
//        return [
//            "Content-Type": "application/json",
//            "DeviceUniqueId": UUID().uuidString,
//            "App-Version": Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
//        ]
    }
}
