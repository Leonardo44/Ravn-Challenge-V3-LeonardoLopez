//
//  SpaceX_RavnTests_LaunchDataTests.swift
//  SpaceX-RavnTests
//
//  Created by Leo on 3/12/23.
//

import XCTest
@testable import SpaceX_Ravn
import ApolloTestSupport
import SpaceXRavnAPI
import Combine

final class SpaceX_RavnTests_MissionServiceTests: XCTestCase {
    func testFetchLaunchListData_SuccesResponse() {
        // given
        let service = MockMissionService(resourceName: "launch_list")
        let expectation = expectation(description: "Load launch list from json file")
        var subscriptions = Set<AnyCancellable>()
        
        // when
        let subscriber = service.fetchLauncList()
        subscriber.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Mock response error: \(failure.localizedDescription)")
            }
        }, receiveValue: { value in
            // Checking if the list is not empty
            if let launches = (value.first?["data"] as? [String: Any])?["launches"] as? [[String: Any]] {
                XCTAssertTrue(!launches.isEmpty)
            } else {
                XCTFail("launches list not found")
            }
        }).store(in: &subscriptions)
        
        // then
        wait(for: [expectation], timeout: 4)
    }
    
    func testFetchLaunchDetailData_SuccesResponse() {
        // given
        let service = MockMissionService(resourceName: "launch_list")
        let expectation = expectation(description: "Load launch detail list from json file")
        let launchId = "5eb87cfeffd86e000604b34d"
        var subscriptions = Set<AnyCancellable>()
        
        // when
        let subscriber = service.fetchLauncDetail(id: launchId)
        subscriber.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Mock response error: \(failure.localizedDescription)")
            }
        }, receiveValue: { value in
            // Checking if the list is not empty
            XCTAssertNotNil(value["id"] as? String)
            XCTAssertTrue(value["id"] as? String == launchId)
        }).store(in: &subscriptions)
        
        // then
        wait(for: [expectation], timeout: 4)
    }
}
