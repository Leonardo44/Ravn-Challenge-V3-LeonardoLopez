//
//  MissionDetailView.swift
//  SpaceX-Ravn
//
//  Created by Leo on 30/11/23.
//

import SwiftUI
import AVKit
import SpaceXRavnAPI

struct MissionDetailView: View {
    var item: LaunchesQuery.Data.Launch
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                YoutubeVideoViewRepresentable(urlVideo: "https://www.youtube.com/embed/xuykqIRHv1M")
                    .frame(height: 300)
                
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
                        Text("[1]")
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
    }
}
