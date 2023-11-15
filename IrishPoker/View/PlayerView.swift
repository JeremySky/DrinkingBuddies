//
//  GameView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct PlayerView: View {
    let player: Player
    let players: [Player]
    var hand: [Card] { player.hand }
    @Binding var currentPlayer: Player
    @Binding var nextPlayer: Player
    var nextPlayerTurn: () -> Void
    
    @State var gamePhase: GamePhase = .guessing
    @State var question: Question = .one
    @State var gameStage: GameStage = .wait
    
    @State var playerGiveOrTake: GiveOrTake = .give
    var pointsToPass: Int {
        let i = question.number - 1
        return hand[i].value.rawValue
    }
    
    //use to prevent user going back to PlayerTurnView prematurely
    //WIP be sure to reset to false during new round
    @State var restrictGoingBack = false
    
    var body: some View {
        ZStack {
            switch gamePhase {
                //MARK: -- GUESSING PHASE
            case .guessing:
                switch gameStage {
                case .guessing:
                    PlayersTurnView(player: player, card: hand[question.number], question: question) { result in
                        playerGiveOrTake = result ? .give : .take
                        gameStage = .pointDistribution
                        restrictGoingBack = true
                    }
                case .pointDistribution:
                    switch playerGiveOrTake {
                    case .give:
                        GiveView(points: pointsToPass) {
                            gameStage = .wait
                            nextPlayerTurn()
                        }
                    case .take:
                        TakeView(points: pointsToPass, player: player) {
                            gameStage = .wait
                            nextPlayerTurn()
                        }
                    }
                case .wait:
                    WaitView(currentPlayer: $currentPlayer, players: players)
                case .end:
                    EmptyView()
                }
                
                //MARK: -- GIVE OR TAKE PHASE
            case .giveTake:
                switch gameStage {
                case .guessing:
                    GiveTakeView()
                case .pointDistribution:
                    switch playerGiveOrTake {
                    case .give:
                        GiveView(points: pointsToPass) {
                            gameStage = .wait
                            nextPlayerTurn()
                        }
                    case .take:
                        TakeView(points: pointsToPass, player: player) {
                            gameStage = .wait
                            nextPlayerTurn()
                        }
                    }
                case .wait:
                    WaitView(currentPlayer: $currentPlayer, players: players)
                case .end:
                    Text("End of game")
                }
            }
        }
        .onAppear {
            if !restrictGoingBack {
                if currentPlayer == player {
                    gameStage = .guessing
                }
            }
        }
    }
    
    enum GameStage {
        case guessing
        case pointDistribution
        case wait
        case end
    }
}

#Preview {
    @State var currentPlayer = Player.test1
    @State var nextPlayer = Player.test2
    let players = [Player.test1, Player.test2, Player.test3, Player.test4]
    return PlayerView(player: Player.test1, players: players, currentPlayer: $currentPlayer, nextPlayer: $nextPlayer) { }
}



enum GiveOrTake {
    case give, take
}


enum CardSelection {
    case one, two, three, four
}
