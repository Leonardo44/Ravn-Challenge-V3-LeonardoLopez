//
//  InternetConnectionStatusView.swift
//  SpaceX-Ravn
//
//  Created by Leo on 1/12/23.
//

import SwiftUI

struct InternetConnectionStatusView: View {
    var internetConnectionStatus: Bool
    
    var body: some View {
        ZStack {
            if internetConnectionStatus {
                Color.green
            } else {
                Color.red
            }
            
            HStack(spacing: 16) {
                Spacer()
                Image(systemName: internetConnectionStatus ? "wifi" : "wifi.slash")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(Color.white)
                    .frame(width: 16, height: 16)
                
                Text(internetConnectionStatus ? NSLocalizedString("INTERNET_CONNECTION_SUCCESS", comment: "") : NSLocalizedString("INTERNET_CONNECTION_FAILED", comment: ""))
                    .foregroundStyle(Color.white)
                    .font(.callout)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
        }
        .frame(height: 28)
    }
}

#Preview {
    InternetConnectionStatusView(internetConnectionStatus: false)
}
