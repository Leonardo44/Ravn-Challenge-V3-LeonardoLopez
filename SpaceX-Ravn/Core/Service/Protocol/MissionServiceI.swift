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
    func fetchLauncList() -> Future <[LaunchesQuery.Data.Launch], NetworkError>
    func fetchLauncDetail(id: String) -> Future <LaunchQuery.Data.Launch, NetworkError>
}
