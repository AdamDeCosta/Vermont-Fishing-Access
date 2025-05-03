//
//  InfoSheet.swift
//  samplebox
//
//  Created by Adam DeCosta on 4/29/25.
//

import MapboxMaps
import SwiftUI

struct InfoSheet<Content: View>: View {
    let infoType: InfoType
    /// Distance in Miles
    let distanceFromUser: CLLocationDistance?

    @ViewBuilder
    let content: () -> Content

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Label {
                        Text(infoType.title)
                    } icon: {
                        Image(systemName: infoType.icon)
                            .foregroundStyle(infoType.iconColor)
                    }

                    if let distanceFromUser {
                        Text("🇺🇸 \(formattedDistance(miles: distanceFromUser))")
                            .font(.caption)
                    }

                    Text(infoType.type)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Divider()
                }

                if let location = infoType.location {
                    DirectionsButton(location: location, destinationName: infoType.title)
                }
            }
            
            ScrollView {
                content()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
        }
        .padding()
    }

    func formattedDistance(miles: CLLocationDistance) -> String {
        Measurement(value: miles, unit: UnitLength.miles).formatted()
    }
}

extension InfoSheet {
    enum InfoType {
        case accessPoint(FishingAccessPoint)

        var type: String {
            switch self {
            case .accessPoint:
                "Access Point"
            }
        }

        var icon: String {
            switch self {
            case .accessPoint:
                "figure.fishing"
            }
        }

        var iconColor: Color {
            switch self {
            case .accessPoint:
                .accessPointCircle
            }
        }

        var title: String {
            switch self {
            case let .accessPoint(accessPoint):
                accessPoint.accessName
            }
        }

        var location: CLLocationCoordinate2D? {
            switch self {
            case let .accessPoint(accessPoint):
                accessPoint.location
            }
        }
    }
}
