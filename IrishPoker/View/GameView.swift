//
//  GameView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/14/23.
//

import SwiftUI

struct GameView: View {
    var players: [Player] = [Player.test1, Player.test2, Player.test3, Player.test4]
    var body: some View {
        TabView {
            ForEach(players, id: \.self) { player in
                PlayerView(player: player)
                    .tabItem {
                        Label(player.name, systemImage: player.icon.rawValue)
                    }
            }
        }
    }
}

#Preview {
    GameView()
}
