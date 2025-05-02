//
//  Fish.swift
//  samplebox
//
//  Created by Adam DeCosta on 4/30/25.
//

// TODO: Add remaining fish from dataset
enum Fish: String, CaseIterable, CustomStringConvertible, CustomDebugStringConvertible {
    case smallmouthBass = "SmallmouthBass"
    case largemouthBass = "LargemouthBass"
    case northernPike = "NorthernPike"
    case chainPickerel = "ChainPickerel"
    case brownTrout = "BrownTrout"
    case rainbowTrout = "RainbowTrout"
    case brookTrout = "BrookTrout"
    case blackCrappie = "BlackCrappie"

    var name: String {
        switch self {
        case .smallmouthBass:
            "Smallmouth Bass"
        case .largemouthBass:
            "Largemouth Bass"
        case .northernPike:
            "Northern Pike"
        case .chainPickerel:
            "Chain Pickerel"
        case .brownTrout:
            "Brown Trout"
        case .rainbowTrout:
            "Rainbow Trout"
        case .brookTrout:
            "Brook Trout"
        case .blackCrappie:
            "Black Crappie"
        }
    }

    var description: String {
        name
    }

    var debugDescription: String {
        rawValue
    }
}
