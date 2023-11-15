//
//  Card.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/14/23.
//

import Foundation
import SwiftUI

struct Card: Hashable {
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
}

enum CardValue: Int, CaseIterable {
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

enum CardSuit: String, CaseIterable {
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
    static var testHandArray1 = [
        Card(value: .six, suit: .clubs),
        Card(value: .nine, suit: .hearts),
        Card(value: .ace, suit: .diamonds),
        Card(value: .ten, suit: .spades)
    ]
    static var testHandArray2 = [
        Card(value: .two, suit: .clubs),
        Card(value: .eight, suit: .clubs),
        Card(value: .seven, suit: .diamonds),
        Card(value: .seven, suit: .hearts)
    ]
    static var testHandArray3 = [
        Card(value: .nine, suit: .diamonds),
        Card(value: .eight, suit: .clubs),
        Card(value: .king, suit: .diamonds),
        Card(value: .nine, suit: .spades)
    ]
    static var testHandArray4 = [
        Card(value: .six, suit: .clubs),
        Card(value: .nine, suit: .diamonds),
        Card(value: .seven, suit: .diamonds),
        Card(value: .queen, suit: .spades)
    ]
    
    static var test1 = Card(value: .ten, suit: .spades, isFlipped: true)
    static var test2 = Card(value: .ten, suit: .clubs)
    static var test3 = Card(value: .seven, suit: .diamonds)
    static var test4 = Card(value: .ten, suit: .spades)
}
