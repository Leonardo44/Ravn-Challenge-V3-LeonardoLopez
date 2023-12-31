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
    @State private var isPresentWebView = false
    @StateObject private var viewModel: MissionDetailViewModel
    
    init(item: LaunchesQuery.Data.Launch) {
        self.item = item
        _viewModel = StateObject(wrappedValue: MissionDetailViewModel(launchId: String(item.id ?? ""), detailLaunch: nil, subscriptions: Set<AnyCancellable>(), dataStatus: .init(.initialize), service: MissionService.shared, dateFormatter: DateFormatter(dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", timeZone: TimeZone.current, locale: Locale(identifier: Locale.current.identifier))))
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
                        EmptyDataView(text: NSLocalizedString("VIDEO_MISSION_NOT_FOUND", comment: ""))
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
                    
                    if let dateUTC = item.launch_date_utc, let date = viewModel.dateFormatter.utcToLocal(dateStr: dateUTC, abbreviation: "UTC", inputFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", outputFormat: "EEE, MMM d, yyyy - h:mm a") {
                        HStack {
                            Text("\(NSLocalizedString("MISSION_RELEASE_DATE", comment: "")): \(date)")
                                .foregroundStyle(Color("TextMainColor"))
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    
                    HStack {
                        Text(viewModel.detailLaunch?.details ?? "")
                            .foregroundStyle(Color("TextMainColor"))
                            .font(.caption)
                            .fontWeight(.regular)
                        Spacer()
                    }
                    
                    if viewModel.detailLaunch?.links?.wikipedia != nil {
                        HStack {
                            Button(action: {
                                isPresentWebView = true
                            }, label: {
                                Text(NSLocalizedString("MISSION_DETAIL_MORE_INFORMATION_BTN", comment: ""))
                                    .foregroundStyle(Color.blue)
                                    .font(.caption)
                                    .fontWeight(.regular)
                            })
                            
                            Spacer()
                        }
                    }
                }
                .padding()
            }
        }
        .accessibilityIdentifier("mission_detail_view")
        .background(Color("AppBackground"))
        .navigationTitle(item.mission_name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchDetail()
            
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
        .fullScreenCover(isPresented: $isPresentWebView, content: {
            if let link = viewModel.detailLaunch?.links?.wikipedia {
                SafariWebView(url: URL(string: link)!)
                    .ignoresSafeArea()
            }
        })
    }
}
