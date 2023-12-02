//
//  ContentView.swift
//  SpaceX-Ravn
//
//  Created by Leo on 30/11/23.
//

import SwiftUI

struct MainSpacexRavnView: View {
    @State private var showInternetConnection: Bool = false
    @State private var internetConnectionStatus: Bool = true
    
    var body: some View {
        NavigationStack(root: {
            ListMissionsView()
            if showInternetConnection {
                InternetConnectionStatusView(internetConnectionStatus: internetConnectionStatus)
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name(ReachabilityMonitor.notificationName)), perform: { notification in
            withAnimation {
                if let status = notification.userInfo?["connection"] as? Bool {
                    internetConnectionStatus = status
                    
                    withAnimation(.easeIn(duration: 0.2)) {
                        showInternetConnection = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        showInternetConnection = false
                    })
                }
            }
        })
        .onAppear {
            ReachabilityMonitor.instance.startListenNotifier()
        }
        .onDisappear {
            ReachabilityMonitor.instance.stopListenNotifier()
        }
    }
}

#Preview {
    MainSpacexRavnView()
}
