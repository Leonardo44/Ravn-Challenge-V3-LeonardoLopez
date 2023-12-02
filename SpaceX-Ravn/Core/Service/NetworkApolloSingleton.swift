//
//  NetworkApolloSingleton.swift
//  SpaceX-Ravn
//
//  Created by Leo on 1/12/23.
//

import Foundation
import Apollo
import SQLite3
import ApolloSQLite

class NetworkApolloSingleton {
    static let cache = InMemoryNormalizedCache()
    static let shared = NetworkApolloSingleton()
    private(set) var apollo: ApolloClient
                                                
    private init() {
        do {
            let documentsPath = NSSearchPathForDirectoriesInDomains(
                .documentDirectory,
                .userDomainMask,
                true
            ).first!
            let documentsURL = URL(fileURLWithPath: documentsPath)
            let sqliteFileURL = documentsURL.appendingPathComponent("spacex_ravn_app.sqlite")
            
            let sqliteCache = try SQLiteNormalizedCache(fileURL: sqliteFileURL)
            let store = ApolloStore(cache: sqliteCache)

            let provider = DefaultInterceptorProvider(store: store)
            let transport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: URL(string: "https://main--spacex-l4uc6p.apollographos.net/graphql")!)
            self.apollo = ApolloClient(networkTransport: transport, store: store)
        } catch {
            self.apollo = ApolloClient(url: URL(string: "https://main--spacex-l4uc6p.apollographos.net/graphql")!)
        }
        
    }
}
