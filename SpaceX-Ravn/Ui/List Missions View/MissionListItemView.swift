//
//  MissionListItemView.swift
//  SpaceX-Ravn
//
//  Created by Leo on 30/11/23.
//

import SwiftUI

struct MissionListItemView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("[1]")
                .foregroundStyle(Color("TextMainColor"))
                .font(.title2)
                .fontWeight(.bold)
            
            Text("[1]")
                .foregroundStyle(Color("TextMainColor"))
                .font(.title3)
                .fontWeight(.regular)
        }
    }
}

#Preview {
    MissionListItemView()
}
