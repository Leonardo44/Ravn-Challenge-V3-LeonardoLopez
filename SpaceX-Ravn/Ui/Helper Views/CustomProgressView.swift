//
//  CustomProgressView.swift
//  SpaceX-Ravn
//
//  Created by Leo on 1/12/23.
//

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 16) {
                ProgressView()
                Text(NSLocalizedString("LOADING_DATA_TEXT", comment: ""))
                    .foregroundStyle(Color("TextMainColor"))
                    .font(.callout)
                    .fontWeight(.bold)
            }
            Spacer()
        }
    }
}

#Preview {
    CustomProgressView()
}
