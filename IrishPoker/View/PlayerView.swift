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
    
    @State var playerStage: PlayerStage = .wait
    @State var playerGiveOrTake: GiveOrTake = .give
    @State var pointsToPass: Int = 0
    @State var restrictGoingBack = false
    
    func playerGives(_ points: Int) {
        pointsToPass = points
        playerGiveOrTake = .give
        playerStage = .pointDistribution
    }
    
    func playerTakes(_ points: Int) {
        pointsToPass = points
        playerGiveOrTake = .take
        playerStage = .pointDistribution
    }
    
    var body: some View {
        ZStack {
            switch playerStage {
            case .guessing:
                switch game.phase {
                case .guessing:
                    PlayersTurnView(player: $player, question: game.question) { isCorrect, points in
                        isCorrect ? playerGives(points) : playerTakes(points)
                        playerStage = .pointDistribution
                        restrictGoingBack = true
                        game.endPlayersTurn()
                    }
                case .giveTake:
                    GiveTakeView(cards: .constant((one: Card.test1, two: Card.test2)))
                }
            case .pointDistribution:
                switch playerGiveOrTake {
                case .give:
                    GiveView(player: $player, points: pointsToPass, players: game.players){ updatedPlayers in
                        game.players = updatedPlayers
                        if player.pointsToTake == 0 {
                            playerStage = .wait
                        } else {
                            playerTakes(player.pointsToTake)
                        }
                    }
                case .take:
                    TakeView(player: $player, countdown: pointsToPass, points: pointsToPass) {
                        restrictGoingBack = false
                        playerStage = .wait
                    }
                }
            case .wait:
                WaitView()
                    .onAppear {
                        if !restrictGoingBack {
                            if game.currentPlayer == player {
                                playerStage = .guessing
                            }
                        }
                    }
            case .end:
                switch game.phase {
                case .guessing:
                    WaitView()
                case .giveTake:
                    Text("END OF GAME")
                }
            }
        }
        .onAppear {
            if player.pointsToTake > 0 {
                playerTakes(player.pointsToTake)
            }
        }
    }
}


#Preview {
    @State var player = Player.test1
    return PlayerView(player: $player)
        .environmentObject(GameViewModel.preview)
}
