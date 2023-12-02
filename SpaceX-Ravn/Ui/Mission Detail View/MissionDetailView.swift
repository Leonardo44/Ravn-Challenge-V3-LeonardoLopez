//
//  MissionDetailView.swift
//  SpaceX-Ravn
//
//  Created by Leo on 30/11/23.
//

import SwiftUI
import AVKit
import SpaceXRavnAPI
import Combine

struct MissionDetailView: View {
    var item: LaunchesQuery.Data.Launch
    @State private var loadingData: Bool = false
    @State private var alertErrorData: Bool = false
    @StateObject private var viewModel: MissionDetailViewModel
    
    init(item: LaunchesQuery.Data.Launch) {
        self.item = item
        _viewModel = StateObject(wrappedValue: MissionDetailViewModel(launchId: String(item.id ?? ""), detailLaunch: nil, subscriptions: Set<AnyCancellable>(), dataStatus: .init(.initialize), service: MissionService.shared))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if loadingData {
                    CustomProgressView()
                } else {
                    if let link = viewModel.detailLaunch?.links?.video_link {
                        YoutubeVideoViewRepresentable(urlVideo: "https://www.youtube.com/embed/\(viewModel.extractYoutubeIdFromLink(link: link ) ?? "")")
                            .frame(height: 300)
                    } else {
                        EmptyDataView(text: "Esta misión no tiene video...")
                    }
                }
                
                VStack(spacing: 20) {
                    HStack {
                        Text(item.mission_name ?? "")
                            .foregroundStyle(Color("TextMainColor"))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    HStack {
                        Text("[1]")
                            .foregroundStyle(Color("TextMainColor"))
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    
                    HStack {
                        Text("[1]")
                            .foregroundStyle(Color("TextMainColor"))
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    
                    HStack {
                        Text(viewModel.detailLaunch?.details ?? "")
                            .foregroundStyle(Color("TextMainColor"))
                            .font(.caption)
                            .fontWeight(.regular)
                        Spacer()
                    }
                }.padding()
            }
        }
        .background(Color("AppBackground"))
        .navigationTitle(item.mission_name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchDetail()
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
