//
//  MissionServiceI.swift
//  SpaceX-Ravn
//
//  Created by Leo on 1/12/23.
//

import Foundation
import SpaceXRavnAPI
import Combine

public protocol MissionServiceI {
    associatedtype DataObjectFetchList
    associatedtype DataObjectFetchDetail
    
    func fetchLauncList() -> Future <[DataObjectFetchList], NetworkError>
    func fetchLauncDetail(id: String) -> Future <DataObjectFetchDetail, NetworkError>
}
