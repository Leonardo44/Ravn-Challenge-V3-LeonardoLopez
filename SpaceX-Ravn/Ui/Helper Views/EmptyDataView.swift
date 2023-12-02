//
//  EmptyDataView.swift
//  SpaceX-Ravn
//
//  Created by Leo on 1/12/23.
//

import SwiftUI

struct EmptyDataView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("No se han encontrado resultados...")
                .foregroundStyle(Color("TextMainColor"))
                .font(.callout)
                .fontWeight(.bold)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    EmptyDataView()
}
