//
//  AccessPointDetails.swift
//  samplebox
//
//  Created by Adam DeCosta on 4/23/25.
//

import MapboxMaps
import SwiftUI

struct AccessPointDetails: View {
    let accessPoint: FishingAccessPoint

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Available Species")
                .font(.headline)

            if accessPoint.fish.isEmpty {
                Text("No data")
            } else {
                ForEach(accessPoint.fish.sorted(using: KeyPathComparator(\.name)), id: \.rawValue) { fish in
                    Text(fish.name)
                        .font(.subheadline)
                }
            }

            Spacer()
        }
    }
}

#Preview {
    AccessPointDetails(
        accessPoint: .init(
            id: "Test",
            accessName: "Test Access",
            fish: [.blackCrappie, .brownTrout],
            location: nil
        )
    )
}
