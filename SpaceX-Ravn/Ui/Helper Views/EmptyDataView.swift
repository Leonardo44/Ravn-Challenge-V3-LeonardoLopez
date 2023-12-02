//
//  EmptyDataView.swift
//  SpaceX-Ravn
//
//  Created by Leo on 1/12/23.
//

import SwiftUI

struct EmptyDataView: View {
    public var text: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(text)
                .foregroundStyle(Color("TextMainColor"))
                .font(.callout)
                .fontWeight(.bold)
            Spacer()
        }
        .padding()
    }
}
