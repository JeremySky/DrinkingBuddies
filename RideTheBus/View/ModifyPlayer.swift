//
//  ModifyPlayer.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/18/23.
//

import SwiftUI

struct ModifyPlayer: View {
    @Binding var player: Player
    @Binding var players: [Player]
    var paddingTop: Bool = false
    var title: String = "Edit Player"
    var saveAction: (String, IconSelection, ColorSelection) -> Void
    
    @EnvironmentObject var settings: SetupViewModel
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
            CustomColorPicker(selectedColor: $player.color, players: $players)
            IconPicker(selectedIcon: $player.icon, color: $player.color, players: $players)
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
    @State var player = Player()
    return ModifyPlayer(player: $player, players: .constant([])) { _, _, _ in }
        .environmentObject(SetupViewModel())
}
#Preview {
    @State var player = Player()
    return Text("Hello")
        .sheet(isPresented: .constant(true), content: {
            ModifyPlayer(player: $player, players: .constant([]), paddingTop: true) { _, _, _ in }
        })
        .environmentObject(SetupViewModel())
}

