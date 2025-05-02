//
//  MapView.swift
//  samplebox
//
//  Created by Adam DeCosta on 4/23/25.
//

import CoreLocation
import OSLog
import SwiftUI
@_spi(Experimental) import MapboxMaps

private let logger = Logger(subsystem: "com.adamdecosta.samplebox", category: "ContentView")

struct MapView: View {
    @Environment(\.scenePhase) var scenePhase
    @Environment(AccessPointStore.self) var accessPointStore
    @Environment(ViewportStore.self) var viewportStore

    @State var selectedAccessPoint: FishingAccessPoint?
    @State var showWildlifeManagementAreas = true

    @State var filteredFish: [Fish] = []

    var body: some View {
        @Bindable var viewportStore = viewportStore
        GeometryReader { _ in
            MapReader { proxy in
                Map(viewport: $viewportStore.viewport) {
                    Puck2D(bearing: .heading)

                    GeoJSONSource(id: "access-areas-source")
                        .data(.url(Bundle.main.url(forResource: "Fishing_Access_Areas", withExtension: "geojson")!))

                    GeoJSONSource(id: "management-areas-source")
                        .data(.url(Bundle.main.url(
                            forResource: "ANR_Lands_Dataset_(Parcel)",
                            withExtension: "geojson"
                        )!))

                    VectorSource(id: "mapbox-terrain-v2")
                        .url("mapbox://mapbox.mapbox-terrain-v2")

                    RasterDemSource(id: "Mapbox Terrain-DEM")
                        .url("mapbox://mapbox.mapbox-terrain-dem-v1")

                    Terrain(sourceId: "Mapbox Terrain-DEM")

                    CircleLayer(id: "access-areas-layer", source: "access-areas-source")
                        .circleColor(.accessPointCircle)
                        .circleStrokeColor(.accessPointCircle)
                        .circleOpacity(0.75)
                        .circleStrokeWidth(1.0)
                        .circleEmissiveStrength(1.0)
                        .circleRadius(Exp(.interpolate) {
                            Exp(.linear)
                            Exp(.zoom)
                            0; 1
                            11; 10
                            16; 30
                        })
                        .filter(fishFilter(selectedFish: filteredFish))

                    FillLayer(id: "management-areas-fill", source: "management-areas-source")
                        .fillColor(.anrParcelsFill)
                        .fillOpacity(0.5)
                        .fillOutlineColor(.anrParcelsFill)
                        .maxZoom(showWildlifeManagementAreas ? 23 : 0)

                    TapInteraction(.layer("access-areas-layer")) { feature, _ in
                        if let accessPoint = accessPointStore.load(from: feature) {
                            selectedAccessPoint = accessPoint
                            withViewportAnimation(.default(maxDuration: 1)) {
                                viewportStore.viewport = .overview(
                                    geometry: feature.geometry,
                                    maxZoom: 13,
                                    offset: CGPoint(x: 0, y: -60)
                                )
                            }
                            logger.info("Tapped on accessPoint: \(accessPoint.accessName)")
                        } else {
                            logger.warning("Failed to open accessPoint")
                        }

                        return true
                    }
                }
                .mapStyle(.outdoors)
                .ornamentOptions(.init(
                    scaleBar: .init(position: .bottomLeading, visibility: .adaptive),
                    compass: .init(visibility: .adaptive)
                ))
                .onMapTapGesture { _ in
                    selectedAccessPoint = nil
                }
                .ignoresSafeArea()
                .onChange(of: scenePhase) {
                    guard scenePhase == .background else { return }

                    viewportStore.saveCurrentViewport(map: proxy.map)
                }
                .overlay(alignment: .topTrailing) {
                    VStack(alignment: .trailing) {
                        LocationButton()

                        MapMenu(showManagementAreas: $showWildlifeManagementAreas, selectedFish: $filteredFish)
                    }
                    .padding(.horizontal, 4)
                    .padding(.top, 50)
                }
                .sheet(item: $selectedAccessPoint) { accessPoint in
                    InfoSheet(
                        infoType: .accessPoint(accessPoint),
                        distanceFromUser: getDistance(
                            from: proxy.location?.latestLocation?.coordinate,
                            to: accessPoint.location
                        )
                    ) {
                        AccessPointDetails(accessPoint: accessPoint)
                    }
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
                }
            }
        }
    }

    func getDistance(from left: CLLocationCoordinate2D?, to right: CLLocationCoordinate2D?) -> CLLocationDistance? {
        guard let left, let right else { return nil }

        let metersDistance = left.distance(to: right)

        return Measurement(value: metersDistance, unit: UnitLength.meters).converted(to: .miles).value
    }

    func fishFilter(selectedFish: [Fish]) -> Exp {
        if selectedFish.isEmpty {
            return Exp(.literal, true)
        }

        var filterArguments: [Exp.Argument] = []

        for fish in selectedFish {
            filterArguments.append(.expression(Exp(.eq, Exp(.get, fish.rawValue), "Yes")))
        }

        return Exp(operator: .any, arguments: filterArguments)
    }
}
