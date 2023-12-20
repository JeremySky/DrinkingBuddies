//
//  Card.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/14/23.
//

import Foundation
import SwiftUI

struct Card: Hashable, Codable {
    var id: String { "\(value.string).\(suit.rawValue)" }
    var value: CardValue
    var suit: CardSuit
    var color: Color {
        switch self.suit {
        case .clubs, .spades:
            Color.black
        case .hearts, .diamonds:
            Color.red
        }
    }
    var isCentered: Bool {
        if self.value == .seven || self.value == .eight || self.value == .ten {
            false
        } else {
            true
        }
    }
    var isFlipped: Bool = false
    
    //MARK: -- Results
    var giveCards = [Card]()
    var takeCards = [Card]()
    
    
    
    
    init(value: CardValue, suit: CardSuit, isFlipped: Bool = false, giveCards: [Card] = [Card](), takeCards: [Card] = [Card]()) {
        self.value = value
        self.suit = suit
        self.isFlipped = isFlipped
        self.giveCards = giveCards
        self.takeCards = takeCards
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(CardValue.self, forKey: .value)
        self.suit = try container.decode(CardSuit.self, forKey: .suit)
        self.isFlipped = try container.decode(Bool.self, forKey: .isFlipped)
        self.giveCards = try container.decodeIfPresent([Card].self, forKey: .giveCards) ?? []
        self.takeCards = try container.decodeIfPresent([Card].self, forKey: .takeCards) ?? []
    }
    
    enum CodingKeys: String, RawRepresentable, CodingKey {
        case value
        case suit
        case isFlipped
        case giveCards
        case takeCards
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.value, forKey: .value)
        try container.encode(self.suit, forKey: .suit)
        try container.encode(self.isFlipped, forKey: .isFlipped)
        try container.encode(self.giveCards, forKey: .giveCards)
        try container.encode(self.takeCards, forKey: .takeCards)
    }
    
    
    
    
    mutating func flip() {
        isFlipped = true
    }
}

enum CardValue: Int, RawRepresentable, CaseIterable, Codable {
    case two = 2
    case three = 3
    case four  = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    case jack = 11
    case queen = 12
    case king = 13
    case ace = 14
    
    var string: String {
        switch self {
        case .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten:
            String(self.rawValue)
        case .jack:
            "J"
        case .queen:
            "Q"
        case .king:
            "K"
        case .ace:
            "A"
        }
    }
}

enum CardSuit: String, RawRepresentable, CaseIterable, Codable {
    case clubs
    case spades
    case hearts
    case diamonds
    
    var icon: String {
        switch self {
        case .clubs:
            "suit.club.fill"
        case .spades:
            "suit.spade.fill"
        case .hearts:
            "suit.heart.fill"
        case .diamonds:
            "suit.diamond.fill"
        }
    }
}


extension Card {
    static var hand1 = [
        Card(value: .two, suit: .clubs),
        Card(value: .three, suit: .hearts),
        Card(value: .four, suit: .diamonds),
        Card(value: .five, suit: .spades)
    ]
    static var hand2 = [
        Card(value: .five, suit: .clubs),
        Card(value: .six, suit: .clubs),
        Card(value: .seven, suit: .diamonds),
        Card(value: .eight, suit: .hearts)
    ]
    static var hand3 = [
        Card(value: .eight, suit: .diamonds),
        Card(value: .nine, suit: .clubs),
        Card(value: .ten, suit: .diamonds),
        Card(value: .king, suit: .clubs)
    ]
    static var hand4 = [
        Card(value: .king, suit: .clubs),
        Card(value: .queen, suit: .diamonds),
        Card(value: .jack, suit: .diamonds),
        Card(value: .ace, suit: .diamonds)
    ]
    
    
    
    
    
    static func newDeck() -> [Card] {
        var tempDeck = [Card]()
        for suit in CardSuit.allCases {
            for value in CardValue.allCases {
                tempDeck.append(Card(value: value, suit: suit))
            }
        }
        return tempDeck.shuffled()
    }
    
    static func randomHand() -> [Card] {
        var hand = [Card]()
        while hand.count < 4 {
            hand.append(Card(value: CardValue.allCases.randomElement()!, suit: CardSuit.allCases.randomElement()!))
        }
        return hand
    }
    
    static var testHandArray1 = [
        Card(value: .two, suit: .clubs, isFlipped: false),
        Card(value: .three, suit: .hearts, isFlipped: false),
        Card(value: .four, suit: .diamonds, isFlipped: false),
        Card(value: .five, suit: .spades, isFlipped: false)
    ]
    static var testHandArray2 = [
        Card(value: .five, suit: .clubs, isFlipped: false),
        Card(value: .six, suit: .clubs, isFlipped: false),
        Card(value: .seven, suit: .diamonds, isFlipped: false),
        Card(value: .eight, suit: .hearts, isFlipped: false)
    ]
    static var testHandArray3 = [
        Card(value: .eight, suit: .diamonds, isFlipped: false),
        Card(value: .nine, suit: .clubs, isFlipped: false),
        Card(value: .ten, suit: .diamonds, isFlipped: false),
        Card(value: .king, suit: .clubs, isFlipped: false)
    ]
    static var testHandArray4 = [
        Card(value: .king, suit: .clubs, isFlipped: false),
        Card(value: .queen, suit: .diamonds, isFlipped: false),
        Card(value: .jack, suit: .diamonds, isFlipped: false),
        Card(value: .ace, suit: .diamonds, isFlipped: false)
    ]
    
    static var testHandArrayResults = [
        Card(value: .two, suit: .clubs, isFlipped: true, giveCards: [Card(value: .two, suit: .diamonds)]),
        Card(value: .three, suit: .hearts, isFlipped: true, giveCards: [Card(value: .three, suit: .clubs), Card(value: .three, suit: .diamonds)]),
        Card(value: .four, suit: .diamonds, isFlipped: true, giveCards: []),
        Card(value: .five, suit: .spades, isFlipped: true, giveCards: [Card(value: .five, suit: .clubs), Card(value: .five, suit: .hearts), Card(value: .five, suit: .diamonds)])
    ]
    
    static var test1 = Card(value: .ten, suit: .spades)
    static var test2 = Card(value: .ten, suit: .clubs)
    static var test3 = Card(value: .seven, suit: .diamonds)
    static var test4 = Card(value: .ten, suit: .spades)
}


