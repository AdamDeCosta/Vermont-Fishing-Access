//
//  AccessPointStore.swift
//  samplebox
//
//  Created by Adam DeCosta on 4/23/25.
//
@_spi(Experimental) import MapboxMaps
import OSLog

private let logger = Logger(subsystem: "io.decosta.samplebox", category: "AccessPointStore")

@Observable
class AccessPointStore {
    private var accessPoints = [FishingAccessPoint.ID: FishingAccessPoint]()

    func load(from feature: FeaturesetFeature) -> FishingAccessPoint? {
        guard let id = getFeatureId(from: feature.properties) else {
            return nil
        }

        return load(id: id, properties: feature.properties, location: feature.geometry.point?.coordinates)
    }

    func load(from feature: Feature) -> FishingAccessPoint? {
        guard let properties = feature.properties,
              let id = getFeatureId(from: properties)
        else {
            return nil
        }

        return load(id: id, properties: properties, location: feature.geometry?.point?.coordinates)
    }

    private func load(id: String, properties: JSONObject, location: CLLocationCoordinate2D?) -> FishingAccessPoint? {
        if let accessPoint = accessPoints[id] {
            return accessPoint
        }

        guard let accessPoint = FishingAccessPoint(id: id, from: properties, location: location) else {
            logger.warning("Could not create access point from feature properties.\nProperties: \(properties)")
            return nil
        }

        accessPoints[id] = accessPoint
        return accessPoint
    }

    private func getFeatureId(from properties: JSONObject) -> String? {
        guard case let .number(featureId) = properties["id"] else {
            logger.warning("Feature does not have a valid id.")
            return nil
        }

        return String(Int(featureId))
    }

    func getAccessPoints(byFish fish: Set<Fish>) -> [FishingAccessPoint] {
        accessPoints.values.filter {
            !$0.fish.isDisjoint(with: fish)
        }
    }
}
