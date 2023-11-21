//
//  CreatePlayerForm.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/18/23.
//

import SwiftUI

struct ModifyPlayer: View {
    @Binding var player: Player
    @Binding var players: [Player]
    var saveAction: (String, IconSelection, ColorSelection) -> Void
    
    
    var body: some View {
        VStack{
            PlayerHeader(player: $player, isForm: true)
            Spacer()
            CustomColorPicker(selectedColor: $player.color, players: $players)
            IconPicker(selectedIcon: $player.icon, color: $player.color, players: $players)
            Spacer()
            
            Button("Save", action: { saveAction(player.name, player.icon, ColorSelection.matching(player.color)) })
                .buttonStyle(.save)
                .disabled(player.name.isEmpty)
        }
    }
}

#Preview {
    @State var player = Player()
    return ModifyPlayer(player: $player, players: .constant([])) { _, _, _ in }
}

