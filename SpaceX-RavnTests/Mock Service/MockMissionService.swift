//
//  MockMissionService.swift
//  SpaceX-RavnTests
//
//  Created by Leo on 4/12/23.
//

import Foundation
@testable import SpaceX_Ravn
import ApolloTestSupport
import SpaceXRavnAPI
import Combine

class MockMissionService: MissionServiceI {
    typealias DataObjectFetchList = [String: Any]
    typealias DataObjectFetchDetail = [String: Any]
    
    private var resourceName: String
    
    init(resourceName: String) {
        self.resourceName = resourceName
    }
    
    func fetchLauncList() -> Future<[[String: Any]], NetworkError> {
        do {
            let bundle = Bundle(for: type(of: self))
            guard let fileUrl = bundle.url(forResource: resourceName, withExtension: "json") else {
                return Future { promise in
                    promise(Result.failure(.serverError))
                }
            }
            let data = try Data(contentsOf: fileUrl)
            let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] ?? ["" : ""]
            
            return Future { promise in
                promise(Result.success([response]))
            }
        } catch {
            return Future { promise in
                promise(Result.failure(.serverError))
            }
        }
    }
    
    func fetchLauncDetail(id: String) -> Future<[String: Any], NetworkError> {
        do {
            let bundle = Bundle(for: type(of: self))
            guard let fileUrl = bundle.url(forResource: resourceName, withExtension: "json") else {
                return Future { promise in
                    promise(Result.failure(.serverError))
                }
            }
            let data = try Data(contentsOf: fileUrl)
            let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] ?? ["" : ""]
            
            if let launches = (response["data"] as? [String: Any])?["launches"] as? [[String: Any]] {
                if let launchDetail = launches.first(where: { $0["id"] as? String == id }) {
                    return Future { promise in
                        promise(Result.success(launchDetail))
                    }
                } else {
                    return Future { promise in
                        promise(Result.failure(.dataNotFound))
                    }
                }
            } else {
                return Future { promise in
                    promise(Result.failure(.serverError))
                }
            }
        } catch {
            return Future { promise in
                promise(Result.failure(.serverError))
            }
        }
    }
}
