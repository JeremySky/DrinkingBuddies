//
//  GameView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct PlayerView: View {
    //1. for passing down user's player data
    //2. parameter for gameStage conditionals
    //(if current player == player { gameStage == .guessing )
    @Binding var player: Player
    
    
    //1. for passing down points data to giveView or takeView
    @State var playerGiveOrTake: GiveOrTake = .give
    var hand: [Card] { player.hand }
    var pointsToPass: Int {
        let i = question.number - 1
        return hand[i].value.rawValue
    }
    
    
    //1. for updating player.hand data **
    @Binding var players: [Player]
    
    
    //1. for updating gameStage
    @State var gamePhase: GamePhase = .guessing
    @State var question: Question = .one
    @State var gameStage: GameStage = .wait
    @Binding var currentPlayer: Player
    var nextPlayerTurn: () -> Void
    
    
    //1. for preventing user from going back to PlayerTurnView prematurely
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
                    WaitView(currentPlayer: $currentPlayer, players: $players)
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
                    WaitView(currentPlayer: $currentPlayer, players: $players)
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
}


#Preview {
    @State var player = Player.test1
    @State var players = Player.testArr
    @State var currentP = Player.test1
    @State var nextP = Player.test2
    return PlayerView(player: $player, playerGiveOrTake: .give, players: $players, gamePhase: GamePhase.guessing, question: .one, gameStage: .wait, currentPlayer: $currentP, nextPlayerTurn: {}, restrictGoingBack: false)
}
