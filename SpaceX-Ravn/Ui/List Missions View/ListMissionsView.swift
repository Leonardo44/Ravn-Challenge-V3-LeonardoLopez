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
    @StateObject var viewModel = ListMissionViewModel(launches: [], subscriptions: Set<AnyCancellable>(), dataStatus: .init(.initialize), service: MissionService.shared, textSearch: "", dateFormatter: DateFormatter(dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", timeZone: TimeZone.current, locale: Locale(identifier: Locale.current.identifier)))
    
    var body: some View {
        VStack {
            if loadingData {
                CustomProgressView()
            }
            
            if !viewModel.launches.isEmpty {
                List {
                    ForEach(viewModel.launches, id: \.self) { launch in
                        NavigationLink(destination: {
                            MissionDetailView(item: launch)
                        }, label: {
                            MissionListItemView(item: launch, dateFormatter: viewModel.dateFormatter)
                                .accessibilityIdentifier("launches_query_list_item_\(launch.id ?? "")")
                        })
                        .listRowBackground(Color("AppBackground"))
                    }
                }
                .listStyle(.plain)
                .accessibilityIdentifier("launches_query_list")
            } else {
                if loadingData == false {
                    EmptyDataView(text: NSLocalizedString("EMPTY_DATA_ERROR", comment: ""))
                        .accessibilityIdentifier("empty_view_list_mission_view")
                }
            }
            Spacer()
        }
        .navigationTitle(NSLocalizedString("MISSION_LIST_VIEW", comment: ""))
        .searchable(text: $viewModel.textSearch)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchList()
            
            if ProcessInfo.processInfo.arguments.contains("isRunningUITests") {
                #if DEBUG
                    print("UI Testing is in progress")
                #endif
            }
        }
        .onReceive(viewModel.dataStatus, perform: { value in
            loadingData = value == .loading
            alertErrorData = value == .error
        })
        .alert(NSLocalizedString("FETCH_DATA_ERROR", comment: ""), isPresented: $alertErrorData, actions: {
            Button(NSLocalizedString("FETCH_DATA_ERROR_BTN", comment: ""), role: .cancel) {
            }
        })
    }
}

#Preview {
    ListMissionsView()
}
