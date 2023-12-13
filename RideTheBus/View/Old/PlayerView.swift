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
                        player.guesses.append(isCorrect)
                        game.turnTaken = true
                        player.stage = .wait
                    }
                    
                    
                case .giveTake:
                    GiveTakeView(player: $player) {
                        game.turnTaken = true
                        player.stage = .wait
                    }
                    
                    
                case .end:
                    PlayerResultsView(player: player)
                        .onAppear {
                            game.endGame()
                        }
                }
            case .give:
                GiveView(player: $player, players: game.players.map({$0.copyAndRemovePointsToTake()})) { temporaryPlayersWithPointsToAdd in
                    addPointsToPlayers(to: temporaryPlayersWithPointsToAdd, from: player)
                    player.stage = .wait
                }
            case .take:
                TakeView(player: $player, countdown: player.pointsToTake, points: player.pointsToTake) {
                    player.stage = .wait
                    if !game.players.map( {
                        $0.pointsToGive == 0 && $0.pointsToTake == 0
                    }).contains(false) && game.turnTaken {
                        game.turnTaken = false
                        game.updateDeck()
                        game.updateCurrentPlayer()
                        game.updateQuestion()
                    }
                }
            case .wait:
                WaitView(player: $player)
                    .onAppear {
                        print("PLAYER: \(player.name)")
                        print("CURRENTPLAYER: \(game.currentPlayer.name)")
                        print("TURNTAKEN: \(game.turnTaken)")
                        

                        if game.phase == .end {
                            player.stage = .end
                        } else if !game.turnTaken && player.id == game.currentPlayer.id {
                            player.stage = .guess
                        } else if player.pointsToGive > 0 {
                            player.stage = .give
                        } else if player.pointsToTake > 0 {
                            player.stage = .take
                        } else if !game.players.map( {
                            $0.pointsToGive == 0 && $0.pointsToTake == 0
                        }).contains(false) && game.turnTaken {
                            game.turnTaken = false
                            game.updateDeck()
                            game.updateCurrentPlayer()
                            game.updateQuestion()
                        }
                    }
                    .environmentObject(game)
            case .end:
                PlayerResultsView(player: player)
            }
        }
    }
    
    func addPointsToPlayers(to takers: [Player], from giver: Player) {
        for tempPlayer in takers {
            if tempPlayer.pointsToTake > 0 {
                for i in game.players.indices {
                    if tempPlayer.id == game.players[i].id {
                        game.players[i].pointsToTake += tempPlayer.pointsToTake
                        game.players[i].takeFrom[giver.index] += tempPlayer.pointsToTake
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
