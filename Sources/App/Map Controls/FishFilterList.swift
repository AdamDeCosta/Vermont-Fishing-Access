//
//  FishFilterList.swift
//  samplebox
//
//  Created by Adam DeCosta on 4/30/25.
//
import SwiftUI

struct FishFilterList: View {
    @Environment(\.dismiss) var dismiss

    @State var selectedFish: [String: Fish] = [:]

    let onSubmit: ([Fish]) -> Void

    let allFish = Fish.allCases.sorted(using: KeyPathComparator(\.name))

    init(selectedFish: [Fish] = [], onSubmit: @escaping ([Fish]) -> Void) {
        self.onSubmit = onSubmit

        let fishDict = selectedFish.reduce(into: [String: Fish]()) { selection, fish in
            selection[fish.rawValue] = fish
        }

        _selectedFish = .init(initialValue: fishDict)
    }

    var body: some View {
        List {
            ForEach(allFish, id: \.rawValue) { fish in
                Button {
                    if selectedFish[fish.rawValue] != nil {
                        selectedFish[fish.rawValue] = nil
                    } else {
                        selectedFish[fish.rawValue] = fish
                    }
                } label: {
                    HStack {
                        Text(fish.name)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Spacer()

                        if selectedFish[fish.rawValue] != nil {
                            Image(systemName: "checkmark")
                        }
                    }
                }
                .foregroundStyle(Color.primary)
                .buttonStyle(.borderless)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    onSubmit(Array(selectedFish.values))
                    dismiss()
                } label: {
                    Text("Done")
                }
            }
        }
        .navigationTitle("Select Species")
    }
}
