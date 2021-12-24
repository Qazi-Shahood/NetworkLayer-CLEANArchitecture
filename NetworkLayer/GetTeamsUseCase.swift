//
//  GetTeamsUseCase.swift
//  NetworkLayer
//
//  Created by Q.M.S on 10/11/2021.
//

import Foundation

protocol GetTeamsUseCase {
    func execute(with team: TeamsRequestDTO, completion: @escaping ((Result<[String], Error>) -> Void))
}

class GetDefaultTeamsUseCase: GetTeamsUseCase {
    
    private let repository: GetTeamsRepository = GetDefaultTeamsRepository()
    
    func execute(with team: TeamsRequestDTO, completion: @escaping ((Result<[String], Error>) -> Void)) {
        repository.getData(for: team) { response, failure, error in
            guard failure == nil,
                  error == nil,
                  let response = response else {
                      return completion(.failure(error ?? AppError.unexpected))
                  }
            completion(.success(response.data.map { $0.team }))
        }
    }
    
}
