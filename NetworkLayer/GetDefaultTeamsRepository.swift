//
//  GetTeamsRepository.swift
//  NetworkLayer
//
//  Created by Q.M.S on 10/11/2021.
//

import Foundation

class GetDefaultTeamsRepository: GetTeamsRepository {
    
    func getData(for teams: TeamsRequestDTO, completion: @escaping (GetTeams.Response?, GetTeams.Failure?, Error?) -> Void) {
        let request = GetTeams(requestObject: teams)
        Network.shared.request(request) { result in
            switch result {
            case .success(let response):
                completion(response, nil, nil)
            case .failure(let failure):
                completion(nil, failure, nil)
            case .error(let err):
                completion(nil, nil, err)
            }
        }
    }
    
}
