//
//  HomeViewModel.swift
//  NetworkLayer
//
//  Created by Q.M.S on 10/11/2021.
//

import Foundation

class HomeViewModel {
    
    private let getTeamsUseCase: GetTeamsUseCase = GetDefaultTeamsUseCase()
    
    var teamsFetched: ((Result<[String], Error>) -> Void)?
    
    var teams: [String]?
    
    func getTeamsData() {
        let fetchWithQuey = TeamsRequestDTO(country: "br", scope: "country", fields: "team")
        getTeamsUseCase.execute(with: fetchWithQuey) { result in
            switch result {
            case .success(let teams):
                self.teams = teams
                self.teamsFetched?(.success(teams))
            case .failure(let err):
                self.teamsFetched?(.failure(err))
            }
        }
    }
    
    
}
