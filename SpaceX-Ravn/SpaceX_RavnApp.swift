//
//  SpaceX_RavnApp.swift
//  SpaceX-Ravn
//
//  Created by Leo on 30/11/23.
//

import SwiftUI

@main
struct SpaceX_RavnApp: App {
    @ObservedObject var coordinator: MainCoordinator = MainCoordinator()
    
    var body: some Scene {
        WindowGroup {
            MainSpacexRavnView()
                .environmentObject(coordinator)
        }
    }
}
