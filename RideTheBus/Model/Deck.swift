//
//  Deck.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/12/23.
//

import Foundation
import SwiftUI


struct Deck: Codable {
    var pile = [Card]()
    
    mutating func createNewPile() {
            var tempPile = [Card]()
            for suit in CardSuit.allCases {
                for value in CardValue.allCases {
                    tempPile.append(Card(value: value, suit: suit))
                }
            }
            pile = tempPile
    }
    
    mutating func shuffle() {
        pile.shuffle()
    }
}

extension Deck {
    static func newDeck() -> Deck {
        var deck = Deck()
        deck.createNewPile()
        deck.shuffle()
        return deck
    }
    
    static func testDeck() -> Deck {
        var deck = Deck.newDeck()
        while deck.pile.count > 2 {
            deck.pile.removeFirst()
        }
        return deck
    }
}
