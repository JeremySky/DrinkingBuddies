//
//  GameView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct OLDPlayerView: View {
    @EnvironmentObject var game: OLDGameViewModel
    @Binding var player: OLDPlayer
    
    var body: some View {
        ZStack {
            switch player.stage {
            case .guessing:
                switch game.phase {
                case .guessing:
                    OLDPlayersTurnView(player: $player, question: $game.question) { isCorrect, points in
                        if isCorrect {
                            player.pointsToGive = points
                        } else {
                            player.pointsToTake = points
                        }
                        player.guesses.append(isCorrect)
                        game.turnTaken = true
                        player.stage = .waiting
                    }
                    
                    
                case .giveTake:
                    OLDGiveTakeView(player: $player) {
                        game.turnTaken = true
                        player.stage = .waiting
                    }
                }
            case .giving:
                OLDGiveView(player: $player, players: game.players.map({$0.copyAndRemovePointsToTake()})) { temporaryPlayersWithPointsToAdd in
                    addPointsToPlayers(to: temporaryPlayersWithPointsToAdd, from: player)
                    player.stage = .waiting
                }
            case .taking:
                OLDTakeView(player: $player, countdown: player.pointsToTake, points: player.pointsToTake) {
                    player.stage = .waiting
                    if !game.players.map( {
                        $0.pointsToGive == 0 && $0.pointsToTake == 0
                    }).contains(false) && game.turnTaken {
                        game.turnTaken = false
                        game.updateDeck()
                        game.updateCurrentPlayer()
                        game.updateQuestion()
                    }
                }
            case .waiting:
                OLDWaitView(player: $player)
                    .onAppear {
                        print("PLAYER: \(player.name)")
                        print("CURRENTPLAYER: \(game.currentPlayer.name)")
                        print("TURNTAKEN: \(game.turnTaken)")
                        
                        
                        if !game.turnTaken && player.id == game.currentPlayer.id {
                            player.stage = .guessing
                        } else if player.pointsToGive > 0 {
                            player.stage = .giving
                        } else if player.pointsToTake > 0 {
                            player.stage = .taking
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
            case .results:
                OLDPlayerResultsView(player: player)
            }
        }
    }
    
    func addPointsToPlayers(to takers: [OLDPlayer], from giver: OLDPlayer) {
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
    @State var player = OLDPlayer.test1
    @State var playerStage = Stage.waiting
    return OLDPlayerView(player: $player)
        .environmentObject(OLDGameViewModel.preview)
}
