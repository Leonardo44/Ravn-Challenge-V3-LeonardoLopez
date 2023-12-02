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
            
            HStack {
                Spacer()
                Text(internetConnectionStatus ? "Internet" : "Not internet")
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
