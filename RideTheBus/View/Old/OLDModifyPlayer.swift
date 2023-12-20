//
//  OLDModifyPlayer.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/18/23.
//

import SwiftUI

struct OLDModifyPlayer: View {
    @Binding var player: OLDPlayer
    @Binding var players: [OLDPlayer]
    var paddingTop: Bool = false
    var title: String = "Edit Player"
    var saveAction: (String, IconSelection, ColorSelection) -> Void
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 0) {
            if paddingTop {
                player.color
                    .frame(height: 20)
            } else {
                Text(title)
                    .foregroundStyle(.white)
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .background(player.color)
            }
            PlayerHeader(player: $player, isForm: true)
            Spacer()
//            CustomColorPicker(selectedColor: $player.color, players: $players)
//            IconPicker(selectedIcon: $player.icon, color: $player.color, players: $players)
            Spacer()
            
            Button("Save", action: {
                saveAction(player.name, player.icon, ColorSelection.matching(player.color))
            })
                .buttonStyle(.save)
                .disabled(player.name.isEmpty)
        }
    }
}

#Preview {
    @State var player = OLDPlayer()
    return OLDModifyPlayer(player: $player, players: .constant([])) { _, _, _ in }
}
#Preview {
    @State var player = OLDPlayer()
    return Text("Hello")
        .sheet(isPresented: .constant(true), content: {
            OLDModifyPlayer(player: $player, players: .constant([]), paddingTop: true) { _, _, _ in }
        })
}

