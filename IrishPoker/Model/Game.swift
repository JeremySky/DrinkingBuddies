//
//  Game.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/15/23.
//

import Foundation

struct Game {
    let id = UUID()
    var deck = Deck()
    var players: [Player]
    var queue: PlayerQueue
    var phase: GamePhase = .guessing
    var question: Question = .one
    var currentPlayer: Player
    
    func getPlayer(using name: String) async -> Player {
        var returnPlayer: Player? = nil
        for player in players {
            if player.name == name {
                returnPlayer = player
            }
        }
        guard let returnPlayer else {
            await resetQueue()
            return await getPlayer(using: name)
        }
        return returnPlayer
    }
    func nextPlayer() async {
        await queue.dequeue()
    }
    func resetQueue() async {
        await queue.reset()
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


enum PlayerStage {
    case guessing
    case pointDistribution
    case wait
    case end
}
