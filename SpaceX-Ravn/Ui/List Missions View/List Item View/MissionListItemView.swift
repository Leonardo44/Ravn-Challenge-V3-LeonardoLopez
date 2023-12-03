//
//  MissionListItemView.swift
//  SpaceX-Ravn
//
//  Created by Leo on 30/11/23.
//

import SwiftUI
import SpaceXRavnAPI

struct MissionListItemView: View {
    var item: LaunchesQuery.Data.Launch
    var dateFormatter: DateFormatter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.mission_name ?? "")
                .foregroundStyle(Color("TextMainColor"))
                .font(.title2)
                .fontWeight(.bold)
            
            if let dateUTC = item.launch_date_utc, let date = dateFormatter.utcToLocal(dateStr: dateUTC, abbreviation: "UTC", inputFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", outputFormat: "EEE, MMM d, yyyy - h:mm a") {
                Text("\(NSLocalizedString("MISSION_RELEASE_DATE", comment: "")): \(date)")
                    .foregroundStyle(Color("TextMainColor"))
                    .font(.title3)
                    .fontWeight(.regular)
            }
        }
    }
}
