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
                switch game.phase {
                case .guessing:
                    PlayersTurnView(player: $player, question: $game.question) { isCorrect, points in
                        if isCorrect {
                            player.pointsToGive = points
                        } else {
                            player.pointsToTake = points
                        }
                        game.turnTaken = true
                        player.stage = .wait
                    }
                    
                    
                case .giveTake:
                    GiveTakeView(player: $player) {
                        game.turnTaken = true
                        player.stage = .wait
                    }
                    
                    
                case .end:
                    Text("END")
                }
            case .give:
                GiveView(player: $player, players: game.players.map({$0.copyAndRemovePointsToTake()})) { temporaryPlayersWithPointsToAdd in
                    addPointsToPlayers(from: temporaryPlayersWithPointsToAdd)
                    player.stage = .wait
                }
            case .take:
                TakeView(player: $player, countdown: player.pointsToTake, points: player.pointsToTake) {
                    player.stage = .wait
                }
            case .wait:
                WaitView(player: $player)
                    .onAppear {
                        if !game.turnTaken && player == game.currentPlayer {
                            player.stage = .guess
                        }
                        if player.pointsToGive > 0 {
                            player.stage = .give
                        } else if player.pointsToTake > 0 {
                            player.stage = .take
                        } else if !game.players.map( {
                            $0.pointsToGive == 0 && $0.pointsToTake == 0
                        }).contains(false) && game.turnTaken {
                            game.updateQuestion()
                            game.updateDeck()
                            game.updateCurrentPlayer()
                            game.turnTaken = false
                        }
                    }
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
