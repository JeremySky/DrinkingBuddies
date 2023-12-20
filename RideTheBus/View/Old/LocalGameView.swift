//
//  LocalGameView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/20/23.
//

import SwiftUI

struct LocalGameView: View {
    @EnvironmentObject var game: OLDGameViewModel
    var body: some View {
        TabView {
            ForEach($game.players.indices, id: \.self) { i in
                OLDPlayerView(player: $game.players[i])
                    .environmentObject(game)
                    .tabItem {
                        Label(game.players[i].name, systemImage: game.players[i].icon.rawValue)
                    }
            }
        }
    }
}

#Preview {
    LocalGameView()
        .environmentObject(OLDGameViewModel.preview)
}
