//
//  Deck.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/12/23.
//

import Foundation
import SwiftUI

struct Deck {
    var pile = [PlayingCard]()
    
    mutating func createNewPile() {
            var tempPile = [PlayingCard]()
            for suit in CardSuit.allCases {
                for value in CardValue.allCases {
                    tempPile.append(PlayingCard(value: value, suit: suit))
                }
            }
            pile = tempPile
    }
    
    mutating func shuffle() {
        pile.shuffle()
    }
}


struct PlayingCard: Identifiable {
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


extension PlayingCard {
    static var testHandArray = [
        PlayingCard(value: .six, suit: .clubs),
        PlayingCard(value: .eight, suit: .clubs),
        PlayingCard(value: .seven, suit: .diamonds),
        PlayingCard(value: .ten, suit: .spades)
    ]
}
