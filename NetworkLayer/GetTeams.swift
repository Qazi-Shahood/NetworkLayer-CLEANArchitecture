//
//  GetTeams.swift
//  NetworkLayer
//
//  Created by Q.M.S on 09/11/2021.
//

import Foundation

class GetTeams: NSObject {
    
    private var requestObject: TeamsRequestDTO

    init(requestObject: TeamsRequestDTO) {
        self.requestObject = requestObject
    }
    
}

extension GetTeams: EndpointProvider {
    
    typealias Response = TeamsResponseDTO
    typealias Body = EmptyDTO
    typealias Failure = BaseDTO<EmptyDTO>
    typealias Query = TeamsRequestDTO
    
    var endpoint: Endpoint<Body, Query> {
        return Endpoint(api: API(baseURL: .defaultApi, path: EndpointPaths.getTeams.getPath()),
                        method: .get,
                        path: [],
                        query: requestObject,
                        headers: .defaultHeaders)
    }
    
}
