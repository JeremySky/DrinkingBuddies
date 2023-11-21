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
                    GiveTakeView(player: $player)
                }
            case .give:
                GiveView(player: $player, points: player.pointsToGive, temporaryPlayers: game.players.map({$0.copyAndRemovePointsToTake()})) { temporaryPlayersWithPointsToAdd in
                    addPointsToPlayers(from: temporaryPlayersWithPointsToAdd)
                    if game.phase == .guessing {
                        game.updateCurrentPlayer()
                        game.updateQuestion()
                    }
                    if player.pointsToTake > 0 {
                        player.stage = .take
                    } else {
                        player.stage = .wait
                        if game.phase == .giveTake && player == game.currentPlayer {
                            game.dequeuePairOfCards()
                            game.updateCurrentPlayer()
                        }
                    }
                }
            case .take:
                TakeView(player: $player, countdown: player.pointsToTake, points: player.pointsToTake) {
                    if player == game.currentPlayer {
                        player.stage = .guess
                    } else {
                        if game.phase == .giveTake && player == game.currentPlayer {
                            game.dequeuePairOfCards()
                            game.updateCurrentPlayer()
                        }
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
            if game.phase == .guessing {
                if player.pointsToTake > 0 {
                   player.stage = .take
               }
            } else if game.phase == .giveTake {
                if player != game.currentPlayer {
                    if player.pointsToGive > 0 {
                        player.stage = .give
                    } else if player.pointsToTake > 0 {
                        player.stage = .take
                    }
                }
            }
        }
    }
    
    func addPointsToPlayers(from players: [Player]) {
        for temporaryPlayer in players {
            if temporaryPlayer.pointsToTake > 0 {
                for i in game.players.indices {
                    if temporaryPlayer.id == game.players[i].id {
                        game.players[i].pointsToTake += temporaryPlayer.pointsToTake
                    }
                }
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
