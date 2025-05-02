//
//  LocationButton.swift
//  samplebox
//
//  Created by Adam DeCosta on 4/24/25.
//
@_spi(Experimental) import MapboxMaps
import SwiftUI

struct LocationButton: View {
    @Environment(ViewportStore.self) var viewportStore

    var body: some View {
        Button {
            withViewportAnimation {
                viewportStore.viewport = .followPuck(zoom: 16)
            }
        } label: {
            Image(systemName: "location.circle.fill")
                .resizable()
                .symbolRenderingMode(.palette)
                .frame(width: 36, height: 36)
                .foregroundStyle(Color.primary, .thickMaterial)
        }
        .frame(width: 48, height: 48)
    }
}
