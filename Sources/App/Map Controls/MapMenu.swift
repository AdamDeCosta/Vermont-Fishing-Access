//
//  MapMenu.swift
//  samplebox
//
//  Created by Adam DeCosta on 4/25/25.
//

import SwiftUI

struct MapMenu: View {
    @Binding var showManagementAreas: Bool
    @Binding var selectedFish: [Fish]

    var wmaFilterTitle: String {
        showManagementAreas ? "Hide Wildlife Management Areas" : "Show Wildlife Management Areas"
    }

    var body: some View {
        Menu {
            Button {
                showManagementAreas.toggle()
            } label: {
                Label(wmaFilterTitle, systemImage: "binoculars.fill")
            }
            NavigationLink {
                FishFilterList(selectedFish: selectedFish) { fish in
                    selectedFish = fish
                }
            } label: {
                Label("Filter Species", systemImage: "fish.fill")
            }

        } label: {
            Image(systemName: "ellipsis.circle.fill")
                .resizable()
                .symbolRenderingMode(.palette)
                .frame(width: 36, height: 36)
                .foregroundStyle(Color.primary, .thickMaterial)
        }
        .frame(width: 48, height: 48)
    }
}
