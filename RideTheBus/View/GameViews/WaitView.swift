//
//  WaitView.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/13/23.
//

import SwiftUI

struct WaitView: View {
    @EnvironmentObject var game: GameManager
    
    var body: some View {
        VStack(spacing: 0) {
            GameHeader(user: game.lobby.players[game.currentPlayerIndex].user) {
                CurrentPlayerHeader(user: game.lobby.players[game.currentPlayerIndex].user)
            }
            
            ScrollView {
                Spacer().frame(height: 20)
                ForEach(game.lobby.players.indices) { i in
                    PlayerOverView(player: $game.lobby.players[i])
                        .padding()
                        .padding(.vertical, 10)
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal)
        }
    }
}

#Preview {
    WaitView()
        .environmentObject(GameManager.previewGameStarted)
}
