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
    
    @State var playerGiveOrTake: GiveOrTake = .give
    var pointsToPass: Int {
        let i = game.question.number - 1
        return player.hand[i].value.rawValue
    }
    @State var playerStage: PlayerStage = .wait
    @State var restrictGoingBack = false
    
    var body: some View {
        ZStack {
            switch playerStage {
            case .guessing:
                switch game.phase {
                case .guessing:
                    PlayersTurnView(player: $player, question: game.question) { result in
                        playerGiveOrTake = result ? .give : .take
                        if result {
                            playerGiveOrTake = .give
                            player.pointsGive = pointsToPass
                        } else {
                            playerGiveOrTake = .take
                            player.pointsTake = pointsToPass
                        }
                        playerStage = .pointDistribution
                        restrictGoingBack = true
                    }
                case .giveTake:
                    GiveTakeView(cards: .constant((one: Card.test1, two: Card.test2)))
                }
            case .pointDistribution:
                switch playerGiveOrTake {
                case .give:
                    GiveView(player: $player, points: pointsToPass, players: game.players){ playersWithUpdateTakePoints in
                        playerStage = .wait
                    }
                case .take:
                    TakeView(player: $player, points: player.pointsTake) {
                        playerStage = .wait
                        game.endPlayersTurn()
                    }
                }
            case .wait:
                WaitView()
            case .end:
                switch game.phase {
                case .guessing:
                    WaitView()
//                    game.phase = .giveTake
//                    playerStage = .wait
                case .giveTake:
                    Text("END OF GAME")
                }
            }
        }
        .onAppear {
            if !restrictGoingBack {
                if game.currentPlayer == player {
                    playerStage = .guessing
                }
            }
        }
    }
}


#Preview {
    @State var player = Player.test1
    return PlayerView(player: $player)
        .environmentObject(GameViewModel.preview)
}
