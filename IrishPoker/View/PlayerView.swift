//
//  GameView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject var game: GameViewModel
    @Binding var player: Player
    
    var body: some View {
        ZStack {
            switch player.stage {
            case .guess:
                if game.phase == .guessing {
                    PlayersTurnView(player: $player, question: $game.question) { isCorrect, points in
                        if isCorrect {
                            player.pointsToGive = points
                            player.stage = .give
                        } else {
                            game.updateCurrentPlayer()
                            game.updateQuestion()
                            player.pointsToTake = points
                            player.stage = .take
                        }
                    }
                } else if game.phase == .giveTake {
                    GiveTakeView(card1: $game.deck.pile[0], card2: $game.deck.pile[1])
                }
            case .give:
                GiveView(player: $player, points: player.pointsToGive, players: game.players) { updatedPlayers in
                    game.players = updatedPlayers
                    game.updateCurrentPlayer()
                    game.updateQuestion()
                    if player.pointsToTake > 0 {
                        player.stage = .take
                    } else {
                        player.stage = .wait
                    }
                }
            case .take:
                TakeView(player: $player, countdown: player.pointsToTake, points: player.pointsToTake) {
                    if player == game.currentPlayer {
                        player.stage = .guess
                    } else {
                        player.stage = .wait
                    }
                }
            case .wait:
                WaitView(player: $player)
                    .environmentObject(game)
            case .end:
                switch game.phase {
                case .guessing:
                    Text("END GUESSING PHASE")
                case .giveTake:
                    Text("END GIVE TAKE PHASE")
                case .end:
                    Text("END GAME")
                }
            }
        }
        .onAppear {
            if player.pointsToTake > 0 {
                player.stage = .take
            }
        }
    }
}


#Preview {
    @State var player = Player.test1
    @State var playerStage = PlayerStage.wait
    return PlayerView(player: $player)
        .environmentObject(GameViewModel.preview)
}
