//
//  BaseDTO.swift
//  NetworkLayer
//
//  Created by Q.M.S on 09/11/2021.
//

import Foundation

struct BaseDTO<Body: DTO>: DTO {
    // var IsSuccess: Bool
    var Data: Body?
    // var Error: ErrorDTO?
}
