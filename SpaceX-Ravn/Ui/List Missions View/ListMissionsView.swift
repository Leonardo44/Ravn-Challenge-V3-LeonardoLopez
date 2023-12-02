//
//  ListMissionsView.swift
//  SpaceX-Ravn
//
//  Created by Leo on 30/11/23.
//

import SwiftUI
import Combine

struct ListMissionsView: View {
    @State private var loadingData: Bool = false
    @State private var alertErrorData: Bool = false
    @StateObject var viewModel = ListMissionViewModel(launches: [], subscriptions: Set<AnyCancellable>(), dataStatus: .init(.initialize), service: MissionService.shared, textSearch: "")
    
    var body: some View {
        VStack {
            if loadingData {
                CustomProgressView()
            }
            
            if !viewModel.launches.isEmpty && loadingData == false {
                List {
                    ForEach(viewModel.launches, id: \.self) { launch in
                        NavigationLink(destination: {
                            MissionDetailView(item: launch)
                        }, label: {
                            MissionListItemView(item: launch)
                                .frame(height: 104)
                        })
                        .listRowBackground(Color("AppBackground"))
                    }
                }
                .listStyle(.plain)
            } else {
                EmptyDataView(text: "No se han encontrado resultados...")
            }
            Spacer()
        }
        .navigationTitle("Misiones")
        .searchable(text: $viewModel.textSearch)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchList()
        }
        .onReceive(viewModel.dataStatus, perform: { value in
            loadingData = value == .loading
            alertErrorData = value == .error
        })
        .alert(Text("Data error"), isPresented: $alertErrorData, actions: {
            Button("OK", role: .cancel) {
            }
        })
    }
}

#Preview {
    ListMissionsView()
}
