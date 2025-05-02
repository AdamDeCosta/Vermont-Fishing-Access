//
//  FishingAccessPoint.swift
//  samplebox
//
//  Created by Adam DeCosta on 4/23/25.
//
import MapboxMaps

struct FishingAccessPoint: Identifiable {
    let id: String
    let accessName: String
    let fish: Set<Fish>
    let location: CLLocationCoordinate2D?

    init(id: String, accessName: String, fish: Set<Fish>, location: CLLocationCoordinate2D?) {
        self.id = id
        self.accessName = accessName
        self.fish = fish
        self.location = location
    }

    init?(id: String, from json: JSONObject, location: CLLocationCoordinate2D?) {
        guard case let .string(accessName) = json["AccessName"] else {
            return nil
        }

        var allFish: Set<Fish> = []
        for (key, value) in json {
            if let fish = Fish(rawValue: key), case let .string(value) = value, value == "Yes" {
                allFish.insert(fish)
            }
        }

        self.id = id
        self.accessName = accessName
        fish = allFish
        self.location = location
    }
}
