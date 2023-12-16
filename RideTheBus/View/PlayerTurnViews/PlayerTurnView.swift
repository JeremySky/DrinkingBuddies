//
//  PlayersTurnView.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/14/23.
//

import SwiftUI

struct PlayerTurnView: View {
    @EnvironmentObject var game: GameManager
    
    var body: some View {
        switch game.phase {
        case .guessing:
            GuessingView(player: $game.lobby.players[game.user.index], question: $game.question) { result, points in
                game.setResultsOfGuessing(result, points)
            }
        case .giveTake:
            Text("GIVE TAKE")
        }
    }
}

#Preview {
    PlayerTurnView()
        .environmentObject(GameManager.previewGameStarted)
}
