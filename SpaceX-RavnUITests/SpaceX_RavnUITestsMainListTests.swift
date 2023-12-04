//
//  SpaceX_RavnUITestsMainListTests.swift
//  SpaceX-RavnUITests
//
//  Created by Leo on 4/12/23.
//

import XCTest

final class SpaceX_RavnUITestsMainListTests: XCTestCase {
    private var app: XCUIApplication?
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app?.launchArguments = ["isRunningUITests"]
        app?.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func testListMissionsView_WhenLoadDataSuccess() {
        // Search list
        let timeout = 4 // To wait load launch list data
        let mainList = app?.collectionViews["launches_query_list"]
        
        XCTAssertTrue(mainList?.waitForExistence(timeout: TimeInterval(timeout)) == true, "Mission list view exists and load data")
        
        // Scroll and find elements by id
        mainList?.scroll(byDeltaX: 0, deltaY: 100)
        mainList?.scroll(byDeltaX: 0, deltaY: 100)
        mainList?.scroll(byDeltaX: 0, deltaY: 100)
        mainList?.scroll(byDeltaX: 0, deltaY: -100)
        mainList?.scroll(byDeltaX: 0, deltaY: -100)
        mainList?.scroll(byDeltaX: 0, deltaY: -100)
        
        let idElementToSearch = "5eb87cdaffd86e000604b32b" // Mission: DemoSat
        let predicateToSearchElement = NSPredicate(format: "identifier CONTAINS 'launches_query_list_item_\(idElementToSearch)'")
        let itemList = mainList?.buttons.containing(predicateToSearchElement)
        
        XCTAssertTrue(itemList?.count == 1, "launches_query_list_item_\(idElementToSearch) exists in view")
    }
    
    func testListMissionsView_OpenMissionDetailView() {
        // Search list
        let timeout = 4 // To wait load launch list data
        let mainList = app?.collectionViews["launches_query_list"]
        
        XCTAssertTrue(mainList?.waitForExistence(timeout: TimeInterval(timeout)) == true, "Mission list view exists and load data")
        
        // Scroll and find elements by id
        mainList?.scroll(byDeltaX: 0, deltaY: 100)
        mainList?.scroll(byDeltaX: 0, deltaY: 100)
        mainList?.scroll(byDeltaX: 0, deltaY: -100)
        mainList?.scroll(byDeltaX: 0, deltaY: -100)
        
        let idElementToSearch = "5eb87cdaffd86e000604b32b" // Mission: DemoSat
        let predicateToSearchElement = NSPredicate(format: "identifier CONTAINS 'launches_query_list_item_\(idElementToSearch)'")
        let itemList = mainList?.buttons.containing(predicateToSearchElement)
        
        if itemList?.count == 1 {
            XCTAssertTrue(itemList?.count == 1, "launches_query_list_item_\(idElementToSearch) exists in view")
            itemList?.firstMatch.tap()
            
            let viewDetail = app?.scrollViews["mission_detail_view"]
            
            XCTAssertTrue(viewDetail?.exists == true, "mission_detail_view appear to user")
            sleep(5)
        } else {
            XCTFail("launches_query_list_item_\(idElementToSearch) dont exists in view")
        }
    }
    
    func testListMissionsView_SearchSpecificMission_Success() {
        // Search list
        let timeout = 4 // To wait load launch list data
        let mainList = app?.collectionViews["launches_query_list"]
        let searchText = "Starlink" // 'Starlink' is text to search in app. API has results with that word.
        
        XCTAssertTrue(mainList?.waitForExistence(timeout: TimeInterval(timeout)) == true, "Mission list view exists and load data")
        
        let searchField = app?.searchFields
        
        if searchField?.count != 0 {
            searchField?.firstMatch.tap()
            searchField?.firstMatch.typeText(searchText)
            
            let timeoutSearch = 3.5
            
            let predicateToSearchElement = NSPredicate(format: "identifier CONTAINS 'launches_query_list_item_'")
            let itemList = mainList?.buttons.containing(predicateToSearchElement)
            
            XCTAssertTrue(itemList?.firstMatch.waitForExistence(timeout: timeoutSearch) == true, "Text search is successful. \(itemList?.count ?? 0) elements found with word '\(searchText)'")
            sleep(5)
        } else {
            XCTFail("Searchable element dont exists in view")
        }
    }
    
    func testListMissionsView_SearchSpecificMission_EmptyResults() {
        // Search list
        let timeout = 4 // To wait load launch list data
        let mainList = app?.collectionViews["launches_query_list"]
        let searchText = "El Salvador" // 'El Salvador' any text to search
        
        XCTAssertTrue(mainList?.waitForExistence(timeout: TimeInterval(timeout)) == true, "Mission list view exists and load data")
        
        let searchField = app?.searchFields
        
        if searchField?.count != 0 {
            searchField?.firstMatch.tap()
            searchField?.firstMatch.typeText(searchText)
            
            let timeoutSearch = 3.5
            
            let emptyView = app?.staticTexts["empty_view_list_mission_view"]
            
            XCTAssertTrue(emptyView?.waitForExistence(timeout: timeoutSearch) == true, "0 elements found when search is '\(searchText)'")
            sleep(5)
        } else {
            XCTFail("Searchable element dont exists in view")
        }
    }
}
