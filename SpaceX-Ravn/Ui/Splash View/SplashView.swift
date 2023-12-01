//
//  SplashView.swift
//  SpaceX-Ravn
//
//  Created by Leo on 30/11/23.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color("AppBackground")
            
            VStack(spacing: 8) {
                Text("SpaceX Ravn Challlenge")
                    .foregroundStyle(Color("TextMainColor"))
                    .fontWeight(.bold)
                    .font(.title)
                
                Text("v1.0.0")
                    .foregroundStyle(Color("TextMainColor"))
                    .fontWeight(.regular)
                    .font(.title3)
            }
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
