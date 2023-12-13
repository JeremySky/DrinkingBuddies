//
//  Game.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/15/23.
//

import Foundation
import SwiftUI

struct OLDGame: Codable {
    var deck: Deck = Deck.newDeck()
    var players: [OLDPlayer] = []
    var phase: GamePhase = .guessing
    var question: Question = .one
    var currentPlayer: OLDPlayer = OLDPlayer.test1
    var waitingRoom: [OLDPlayer] = []
    var turnTaken = false
    var host = OLDPlayer()
    
    
    init(deck: Deck, players: [OLDPlayer], phase: GamePhase, question: Question, currentPlayer: OLDPlayer, waitingRoom: [OLDPlayer], turnTaken: Bool = false, host: OLDPlayer = OLDPlayer()) {
        self.deck = deck
        self.players = players
        self.phase = phase
        self.question = question
        self.currentPlayer = currentPlayer
        self.waitingRoom = waitingRoom
        self.turnTaken = turnTaken
        self.host = host
    }
    
    init() {
        self.deck = Deck.newDeck()
        self.players = []
        self.phase = .guessing
        self.question = .one
        self.currentPlayer = OLDPlayer.test1
        self.waitingRoom = []
        self.turnTaken = false
        self.host = OLDPlayer()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.deck = try container.decode(Deck.self, forKey: .deck)
        self.players = try container.decodeIfPresent([OLDPlayer].self, forKey: .players) ?? []
        self.phase = try container.decode(GamePhase.self, forKey: .phase)
        self.question = try container.decode(Question.self, forKey: .question)
        self.currentPlayer = try container.decode(OLDPlayer.self, forKey: .currentPlayer)
        self.waitingRoom = try container.decodeIfPresent([OLDPlayer].self, forKey: .waitingRoom) ?? []
        self.turnTaken = try container.decode(Bool.self, forKey: .turnTaken)
        self.host = try container.decode(OLDPlayer.self, forKey: .host)
    }
    
    enum CodingKeys: CodingKey {
        case deck
        case players
        case phase
        case question
        case currentPlayer
        case waitingRoom
        case turnTaken
        case host
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.deck, forKey: .deck)
        try container.encode(self.players, forKey: .players)
        try container.encode(self.phase, forKey: .phase)
        try container.encode(self.question, forKey: .question)
        try container.encode(self.currentPlayer, forKey: .currentPlayer)
        try container.encode(self.waitingRoom, forKey: .waitingRoom)
        try container.encode(self.turnTaken, forKey: .turnTaken)
        try container.encode(self.host, forKey: .host)
    }
}

enum GamePhase: String, RawRepresentable, Codable {
    case guessing
    case giveTake
    case end
}

enum Question: String, RawRepresentable, Codable {
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
    
    var answers: [String] {
        switch self {
        case .one:
            ["Red", "Black"]
        case .two:
            ["arrowshape.up.circle", "arrowshape.down.circle", "equal.circle"]
        case .three:
            ["arrow.up.right.and.arrow.down.left.circle", "arrow.down.left.and.arrow.up.right.circle", "equal.circle"]
        case .four:
            [CardSuit.hearts.icon, CardSuit.clubs.icon, CardSuit.diamonds.icon, CardSuit.spades.icon]
        }
    }
}

