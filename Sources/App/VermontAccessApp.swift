//
//  VermontAccessApp.swift
//  samplebox
//
//  Created by Adam DeCosta on 4/23/25.
//

import SwiftUI

@main
struct VermontAccessApp: App {
    @Environment(\.scenePhase) var scenePhase
    let accessPointStore = AccessPointStore()
    @State var viewportStore = ViewportStore()

    @State var isLoading = true

    var body: some Scene {
        WindowGroup {
            if isLoading {
                Splash()
                    .task {
                        viewportStore.loadSavedViewport()
                        isLoading = false
                    }
            } else {
                NavigationStack {
                    MapView()
                        .environment(accessPointStore)
                        .environment(viewportStore)
                }
            }
        }
    }
}
