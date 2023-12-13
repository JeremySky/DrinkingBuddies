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
    
    init(pile: [Card] = [Card]()) {
        self.pile = pile
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pile = try container.decodeIfPresent([Card].self, forKey: .pile) ?? []
    }
    
    enum CodingKeys: CodingKey {
        case pile
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.pile, forKey: .pile)
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
