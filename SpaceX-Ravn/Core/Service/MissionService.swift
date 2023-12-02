//
//  MissionService.swift
//  SpaceX-Ravn
//
//  Created by Leo on 30/11/23.
//

import Foundation
import SpaceXRavnAPI
import Combine

final class MissionService: MissionServiceI {
    static let shared = MissionService()
    
    private init() {
    }
    
    func fetchLauncList() -> Future <[LaunchesQuery.Data.Launch], NetworkError> {
        return Future { promise in
            NetworkApolloSingleton.shared.apollo.fetch(query: LaunchesQuery()) { result in
                switch result {
                case .success(let graphQLResult):
                    promise(Result.success(graphQLResult.data?.launches?.compactMap({ $0 }) ?? []))
                case .failure(_):
                    promise(Result.failure(.serverError))
                }
            }
        }
    }
}
