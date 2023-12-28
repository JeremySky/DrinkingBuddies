//
//  Game.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/11/23.
//

import Foundation

enum Phase: String, RawRepresentable, Codable {
    case guessing
    case giveTake
    case results
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

struct Game {
    var deck: Deck
    var lobby: Lobby
    var phase: Phase
    var question: Question
    var currentPlayerIndex: Int
    var turnTaken: Bool
    var host: User
    var hasStarted: Bool
    var id: String
    
    init(deck: Deck = Deck(pile: Card.newDeck()), lobby: Lobby = Lobby(players: []), phase: Phase = .guessing, question: Question = .one, currentPlayerIndex: Int = 0, turnTaken: Bool = false, host: User, hasStarted: Bool = false, id: String) {
        self.deck = deck
        self.lobby = lobby
        self.phase = phase
        self.question = question
        self.currentPlayerIndex = currentPlayerIndex
        self.turnTaken = turnTaken
        self.host = host
        self.hasStarted = hasStarted
        self.id = id
    }
    
    init(user: User, gameID: String) {
        self.init(host: user, id: gameID)
        self.lobby = Lobby(players: [Player(user: user)])
    }
    
    mutating func reset() {
        self.deck = Deck(pile: Card.newDeck())
        self.lobby.players.indices.forEach({lobby.players[$0].reset()})
        self.phase = .guessing
        self.question = .one
        self.currentPlayerIndex = 0
        self.turnTaken = false
        self.hasStarted = false
    }
}

extension Game {
    static var testRoomID = "QWERT"
    static var previewGameHasStarted = Game(deck: Deck(pile: Card.newDeck()), lobby: Lobby.previewGameHasStarted, phase: .guessing, question: .one, currentPlayerIndex: 0, turnTaken: false, host: User.test1, hasStarted: true, id: Game.testRoomID)
    static var previewResults = Game(deck: Deck(pile: []), lobby: Lobby.previewResults, phase: .giveTake, question: .four, currentPlayerIndex: 2, turnTaken: true, host: User.test1, hasStarted: true, id: Game.testRoomID)
}














extension Game: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.deck = try container.decodeIfPresent(Deck.self, forKey: .deck) ?? Deck(pile: [])
        self.lobby = try container.decodeIfPresent(Lobby.self, forKey: .lobby) ?? Lobby(players: [])
        self.phase = try container.decode(Phase.self, forKey: .phase)
        self.question = try container.decode(Question.self, forKey: .question)
        self.currentPlayerIndex = try container.decode(Int.self, forKey: .currentPlayerIndex)
        self.turnTaken = try container.decode(Bool.self, forKey: .turnTaken)
        self.host = try container.decode(User.self, forKey: .host)
        self.hasStarted = try container.decode(Bool.self, forKey: .hasStarted)
        self.id = try container.decode(String.self, forKey: .id)
    }
    
    enum CodingKeys: CodingKey {
        case deck
        case lobby
        case phase
        case question
        case currentPlayerIndex
        case turnTaken
        case host
        case hasStarted
        case id
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.deck, forKey: .deck)
        try container.encode(self.lobby, forKey: .lobby)
        try container.encode(self.phase, forKey: .phase)
        try container.encode(self.question, forKey: .question)
        try container.encode(self.currentPlayerIndex, forKey: .currentPlayerIndex)
        try container.encode(self.turnTaken, forKey: .turnTaken)
        try container.encode(self.host, forKey: .host)
        try container.encode(self.hasStarted, forKey: .hasStarted)
        try container.encode(self.id, forKey: .id)
    }
}
