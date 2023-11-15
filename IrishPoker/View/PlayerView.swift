//
//  GameView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct PlayerView: View {
    let player: Player
    var hand: [Card] { player.hand }
    @Binding var question: Question
    @Binding var gamePhase: GamePhase
    @Binding var currentPlayer: Player?
    @Binding var nextPlayer: Player?
    @State var gameStage: GameStage = .wait
    @State var playerGiveOrTake: GiveOrTake = .give
    var nextPlayerTurn: () async -> Void
    
    
    
    var pointsToPass: Int {
        let i = question.number - 1
        return hand[i].value.rawValue
    }
    
    
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
                        currentPlayer = nextPlayer
                    }
                case .pointDistribution:
                    switch playerGiveOrTake {
                    case .give:
                        GiveView(points: pointsToPass) {
                            gameStage = .wait
                            Task {
                                await nextPlayerTurn()
                            }
                        }
                    case .take:
                        TakeView(points: pointsToPass, player: player) {
                            gameStage = .wait
                            Task {
                                await nextPlayerTurn()
                            }
                        }
                    }
                case .wait:
                    WaitView(currentPlayer: $currentPlayer)
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
                            Task {
                                await nextPlayerTurn()
                            }
                        }
                    case .take:
                        TakeView(points: pointsToPass, player: player) {
                            gameStage = .wait
                            Task {
                                await nextPlayerTurn()
                            }
                        }
                    }
                case .wait:
                    WaitView(currentPlayer: $currentPlayer)
                case .end:
                    Text("End of game")
                }
                
                
                
                
                //            switch guessingPhase {
                //            case .guessing:
                //                PlayersTurnView(player: player, card: hand[question.number], question: question) { result in
                //                    playerGiveOrTake = result ? .give : .take
                //                    guessingPhase = .pointDistribution
                //                }
                //            case .pointDistribution:
                //                switch playerGiveOrTake {
                //                case .give:
                //                    GiveView(points: pointsToPass) {
                //                        guessingPhase = .wait
                //                    }
                //                case .take:
                //                    TakeView(points: pointsToPass, player: player) {
                //                        guessingPhase = .wait
                //                    }
                //                }
                //            case .wait:
                //                WaitView()
                //            case .end:
                //                EmptyView()
                //            }
                //
                //            switch giveTakePhase {
                //            case .guessing:
                //                GiveTakeView()
                //            case .pointDistribution:
                //                switch playerGiveOrTake {
                //                case .give:
                //                    GiveView(points: pointsToPass) {
                //                    }
                //                case .take:
                //                    TakeView(points: pointsToPass, player: player) {
                //                    }
                //                }
                //            case .wait:
                //                WaitView()
                //            case .end:
                //                EmptyView()
                //            }
            }
        }
        .onAppear {
            if currentPlayer == player {
                gameStage = .guessing
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
    @State var currentPlayer: Player? = Player.test1
    @State var nextPlayer: Player? = Player.test2
    @State var gamePhase = GamePhase.guessing
    return PlayerView(player: Player.test1, question: .constant(Question.one), gamePhase: $gamePhase, currentPlayer: $currentPlayer, nextPlayer: $nextPlayer) { }
}



enum GiveOrTake {
    case give, take
}


enum CardSelection {
    case one, two, three, four
}
