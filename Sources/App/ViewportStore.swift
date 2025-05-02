//
//  ViewportStore.swift
//  samplebox
//
//  Created by Adam DeCosta on 4/23/25.
//
import CoreLocation
@_spi(Experimental) import MapboxMaps
import OSLog
import SwiftUI

private let montpelierCoordinates = CLLocationCoordinate2D(latitude: 44.25939, longitude: -72.57599)

private let logger = Logger(subsystem: "io.decosta.samplebox", category: "ViewportStore")

@Observable
class ViewportStore {
    static let DefaultZoom: CGFloat = 7

    var viewport: Viewport = .camera(center: montpelierCoordinates, zoom: DefaultZoom)

    func loadSavedViewport() {
        guard let data = UserDefaults.standard.data(forKey: "lastSavedCoordinates"),
              let coordinates = try? JSONDecoder().decode(CameraPosition.self, from: data)
        else {
            return
        }

        let zoom = UserDefaults.standard.object(forKey: "lastSavedZoomLevel") as? CGFloat

        viewport = .camera(
            center: CLLocationCoordinate2D(
                latitude: coordinates.latitude,
                longitude: coordinates.longitude
            ),
            zoom: zoom ?? Self.DefaultZoom
        )
    }

    func saveCurrentViewport(map: MapboxMap?) {
        if let coordinates = map?.cameraState.center, let zoom = map?.cameraState.zoom {
            let lastPosition = CameraPosition(latitude: coordinates.latitude, longitude: coordinates.longitude)
            logger
                .info("Saving coordinates: latitude - \(lastPosition.latitude), longitude - \(lastPosition.longitude)")

            guard let encoded = try? JSONEncoder().encode(lastPosition) else {
                logger.warning("Unable to encode coordinates, cannot save.")
                return
            }

            UserDefaults.standard.set(encoded, forKey: "lastSavedCoordinates")
            UserDefaults.standard.set(zoom, forKey: "lastSavedZoomLevel")
        } else {
            logger.warning("Unable to save coordinates")
        }
    }
}

private struct CameraPosition: Codable {
    let latitude: Double
    let longitude: Double
}
