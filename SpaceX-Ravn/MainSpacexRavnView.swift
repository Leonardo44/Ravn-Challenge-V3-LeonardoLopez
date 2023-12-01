//
//  ContentView.swift
//  SpaceX-Ravn
//
//  Created by Leo on 30/11/23.
//

import SwiftUI

struct MainSpacexRavnView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ListMissionsView()
                .navigationDestination(for: PageCoordinator.self) { destination in
                    switch destination {
                    case .missionDetail(let missionId):
                        MissionDetailView()
                    }
                }
        }
    }
}

#Preview {
    MainSpacexRavnView()
}
