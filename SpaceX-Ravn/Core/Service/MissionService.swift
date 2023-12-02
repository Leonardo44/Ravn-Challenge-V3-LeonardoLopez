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
    
    func fetchLauncDetail(id: String) -> Future<LaunchQuery.Data.Launch, NetworkError> {
        return Future { promise in
            NetworkApolloSingleton.shared.apollo.fetch(query: LaunchQuery(launchId: ID(stringLiteral: id))) { result in
                switch result {
                case .success(let graphQLResult):
                    if let launch = graphQLResult.data?.launch {
                        promise(Result.success(launch))
                    } else {
                        promise(Result.failure(.serverError))
                    }
                case .failure(_):
                    promise(Result.failure(.serverError))
                }
            }
        }
    }
}
