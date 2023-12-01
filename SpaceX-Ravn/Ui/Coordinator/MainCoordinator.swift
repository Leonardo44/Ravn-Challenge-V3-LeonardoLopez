//
//  MainCoordinator.swift
//  SpaceX-Ravn
//
//  Created by Leo on 30/11/23.
//

import Foundation
import SwiftUI

// MARK: - Coordinator
final class MainCoordinator: ObservableObject {
    @Published public var path: NavigationPath = NavigationPath()
    
    // MARK: - Push navigation functions
    func navigate(to destination: PageCoordinator) {
        path.append(destination)
    }
}

// MARK: - PageCoordinator
public enum PageCoordinator: Codable, Hashable {
    case missionDetail(missionId: String)
}
