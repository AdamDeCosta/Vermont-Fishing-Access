//
//  AccessPointStoreTests.swift
//  VTAccess
//
//  Created by Adam DeCosta on 5/2/25.
//

@_spi(Experimental) import MapboxMaps
import Testing
@testable import VTAccess

@Suite("AccessPointStoreTests")
struct AccessPointStoreTests {
    @Test func testAccessPointStoreInitialization() async throws {
        let accessPointStore = AccessPointStore()

        let geoJsonFeature = Feature(geometry: .point(.init(.init(latitude: 0, longitude: 0))))
            .properties([
                "AccessName": "Test Access Point",
                "id": 123,
                "BrownTrout": "Yes",
                "SmallmouthBass": "No",
            ])

        let feature = FeaturesetFeature(
            id: .init(id: "123"),
            featureset: .featureset("TestFeatureset"),
            geoJsonFeature: geoJsonFeature,
            state: .init()
        )

        let accessPoint = try #require(accessPointStore.load(from: feature))

        #expect(accessPoint.id == "123")
        #expect(accessPoint.accessName == "Test Access Point")
    }
}
