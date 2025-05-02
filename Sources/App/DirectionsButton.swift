//
//  DirectionsButton.swift
//  samplebox
//
//  Created by Adam DeCosta on 4/29/25.
//

import MapKit
import SwiftUI

struct DirectionsButton: View {
    let location: CLLocationCoordinate2D
    let destinationName: String

    var body: some View {
        Button {
            openDirections()
        } label: {
            Image(systemName: "map.circle.fill")
                .font(.title)
        }
    }

    func openDirections() {
        let locationItem = MKMapItem(placemark: MKPlacemark(coordinate: location))
        locationItem.name = destinationName
        locationItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}

#Preview {
    DirectionsButton(location: .init(), destinationName: "Test Destination")
}
