//
//  Game.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/15/23.
//

import Foundation

struct Game {
    var id = UUID()
    var deck = Deck()
    var players: [Player]
    var queue: PlayerQueue
    var phase = GamePhase.guessing
    
    func getCurrentPlayerName() async -> String {
        await queue.peekCurrent()
    }
    func getNextPlayerName() async -> String {
        await queue.peekNext()
    }
    
    func shiftPlayers() async {
        await queue.rotateQueue()
    }
}

enum GamePhase {
    case guessing
    case giveTake
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


enum GameStage {
    case guessing
    case pointDistribution
    case wait
    case end
}