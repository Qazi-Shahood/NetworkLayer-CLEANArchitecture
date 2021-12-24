//
//  GetTeamsRepository.swift
//  NetworkLayer
//
//  Created by Q.M.S on 10/11/2021.
//

import Foundation

protocol GetTeamsRepository {
    
    func getData(for teams: TeamsRequestDTO, completion: @escaping (GetTeams.Response?, GetTeams.Failure?, Error?) -> Void)
    
}
