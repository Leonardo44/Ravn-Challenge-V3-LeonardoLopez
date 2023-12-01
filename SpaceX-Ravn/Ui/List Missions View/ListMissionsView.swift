//
//  ListMissionsView.swift
//  SpaceX-Ravn
//
//  Created by Leo on 30/11/23.
//

import SwiftUI

struct ListMissionsView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    @State var textSearch: String = ""
    
    var body: some View {
        VStack {
            List {
                ForEach(0..<100) { contact in
                    MissionListItemView()
                        .frame(height: 104)
                        .onTapGesture {
                            coordinator.navigate(to: .missionDetail(missionId: ""))
                        }
                }
            }
            .listStyle(.grouped)
        }
        .background(Color("AppBackground"))
        .navigationTitle("Misiones")
        .searchable(text: $textSearch)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ListMissionsView()
}
