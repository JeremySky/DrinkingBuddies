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
    @State var gamePhase: GamePhase = .guessingPhase
    @State var playerGiveOrTake: GiveOrTake = .give
    var pointsToPass: Int {
        let i = question.number - 1
        return hand[i].value.rawValue
    }
    
    
    var body: some View {
        ZStack {
            switch gamePhase {
            case .guessingPhase:
                PlayersTurnView(player: player, card: hand[question.number], question: question) { result in
                    playerGiveOrTake = result ? .give : .take
                    gamePhase = .pointDistributePhase
                }
            case .pointDistributePhase:
                switch playerGiveOrTake {
                case .give:
                    GiveView(points: pointsToPass) {
                        gamePhase = .waitPhase
                    }
                case .take:
                    TakeView(points: pointsToPass, player: player) {
                        gamePhase = .waitPhase
                    }
                }
            case .giveTakePhase:
                GiveTakeView()
            case .waitPhase:
                WaitView()
            }
        }
    }
    
    enum GamePhase {
        case guessingPhase
        case pointDistributePhase
        case giveTakePhase
        case waitPhase
    }
}

#Preview {
    PlayerView(player: Player.test1, question: .constant(Question.one))
}


enum Question: String, RawRepresentable {
    case one = "Guess the Color"
    case two = "Higher or Lower"
    case three = "Inside or Outside"
    case four = "Guess the Suit"
    
    var number: Int {
        switch self {
        case .one:
            1
        case .two:
            2
        case .three:
            3
        case .four:
            4
        }
    }
}

enum GiveOrTake {
    case give, take
}


enum CardSelection {
    case one, two, three, four
}
