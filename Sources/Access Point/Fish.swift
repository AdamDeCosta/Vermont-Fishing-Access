//
//  Fish.swift
//  samplebox
//
//  Created by Adam DeCosta on 4/30/25.
//

enum Fish: String, CaseIterable, CustomStringConvertible, CustomDebugStringConvertible {
    case bowfin = "Bowfin"
    case carp = "Carp"
    case channelCatfish = "ChannelCatfish"
    case whiteCrappie = "WhiteCrappie"
    case longnoseGar = "LongnoseGar"
    case muskellunge = "Muskellunge"
    case whitePerch = "WhitePerch"
    case americanShad = "AmericanShad"
    case sheepshead = "Sheepshead"
    case lakeWhitefish = "LakeWhitefish"
    case brookTrout = "BrookTrout"
    case brownTrout = "BrownTrout"
    case rainbowTrout = "RainbowTrout"
    case lakeTrout = "LakeTrout"
    case landlockedSalmon = "LandlockedSalmon"
    case rainbowSmelt = "RainbowSmelt"
    case yellowPerch = "YellowPerch"
    case walleye = "Walleye"
    case northernPike = "NorthernPike"
    case chainPickerel = "ChainPickerel"
    case largemouthBass = "LargemouthBass"
    case smallmouthBass = "SmallmouthBass"
    case bullhead = "Bullhead"
    case panfish = "Panfish"
    case blackCrappie = "BlackCrappie"
    case burbot = "Burbot"

    var name: String {
        switch self {
        case .bowfin:
            "Bowfin"
        case .carp:
            "Carp"
        case .channelCatfish:
            "Channel Catfish"
        case .whiteCrappie:
            "White Crappie"
        case .longnoseGar:
            "Longnose Gar"
        case .muskellunge:
            "Muskellunge"
        case .whitePerch:
            "White Perch"
        case .americanShad:
            "American Shad"
        case .sheepshead:
            "Sheepshead"
        case .lakeWhitefish:
            "Lake Whitefish"
        case .brookTrout:
            "Brook Trout"
        case .brownTrout:
            "Brown Trout"
        case .rainbowTrout:
            "Rainbow Trout"
        case .lakeTrout:
            "Lake Trout"
        case .landlockedSalmon:
            "Landlocked Salmon"
        case .rainbowSmelt:
            "Rainbow Smelt"
        case .yellowPerch:
            "Yellow Perch"
        case .walleye:
            "Walleye"
        case .northernPike:
            "Northern Pike"
        case .chainPickerel:
            "Chain Pickerel"
        case .largemouthBass:
            "Largemouth Bass"
        case .smallmouthBass:
            "Smallmouth Bass"
        case .bullhead:
            "Bullhead"
        case .panfish:
            "Panfish"
        case .blackCrappie:
            "Black Crappie"
        case .burbot:
            "Burbot"
        }
    }

    var description: String {
        name
    }

    var debugDescription: String {
        rawValue
    }
}
