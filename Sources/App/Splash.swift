//
//  Splash.swift
//  samplebox
//
//  Created by Adam DeCosta on 4/23/25.
//

import SwiftUI

struct Splash: View {
    @State var isAnimating: Bool = false

    var body: some View {
        VStack {
            Image("Splash")
                .resizable()
                .frame(width: 64, height: 64)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .scaleEffect(isAnimating ? 1 : 1.5)
                .animation(.easeInOut(duration: 2.0).repeatForever(), value: isAnimating)
                .onAppear {
                    isAnimating = true
                }
        }
    }
}
