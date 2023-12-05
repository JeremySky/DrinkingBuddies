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
    
    
    
    mutating func flip() {
        isFlipped = true
    }
}

enum CardValue: Int, CaseIterable, Codable {
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

enum CardSuit: String, CaseIterable, Codable {
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
//    static var testHandArray1 = [
//        Card(value: .two, suit: .clubs),
//        Card(value: .three, suit: .hearts),
//        Card(value: .four, suit: .diamonds),
//        Card(value: .five, suit: .spades)
//    ]
//    static var testHandArray2 = [
//        Card(value: .five, suit: .clubs),
//        Card(value: .six, suit: .clubs),
//        Card(value: .seven, suit: .diamonds),
//        Card(value: .eight, suit: .hearts)
//    ]
//    static var testHandArray3 = [
//        Card(value: .eight, suit: .diamonds),
//        Card(value: .nine, suit: .clubs),
//        Card(value: .ten, suit: .diamonds),
//        Card(value: .king, suit: .clubs)
//    ]
//    static var testHandArray4 = [
//        Card(value: .king, suit: .clubs),
//        Card(value: .queen, suit: .diamonds),
//        Card(value: .jack, suit: .diamonds),
//        Card(value: .ace, suit: .diamonds)
//    ]
    
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


