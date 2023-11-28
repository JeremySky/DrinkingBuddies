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
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 0) {
            if paddingTop {
                player.color
                    .frame(height: 20)
            }
            PlayerHeader(player: $player, isForm: true)
            Spacer()
            CustomColorPicker(selectedColor: $player.color, players: $players)
            IconPicker(selectedIcon: $player.icon, color: $player.color, players: $players)
            Spacer()
            
            Button("Save", action: { saveAction(player.name, player.icon, ColorSelection.matching(player.color)) })
                .buttonStyle(.save)
                .disabled(player.name.isEmpty)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {dismiss()}) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(width: 25, height: 20)
                        .fontWeight(.heavy)
                }
            }
            ToolbarItem(placement: .principal) {
                Text(title)
                    .foregroundStyle(.white)
                    .font(.title3)
                    .fontWeight(.bold)
            }
        }
    }
}

#Preview {
    @State var player = Player()
    return ModifyPlayer(player: $player, players: .constant([])) { _, _, _ in }
}
#Preview {
    @State var player = Player()
    return Text("Hello")
        .sheet(isPresented: .constant(true), content: {
            ModifyPlayer(player: $player, players: .constant([]), paddingTop: true) { _, _, _ in }
        })
}

