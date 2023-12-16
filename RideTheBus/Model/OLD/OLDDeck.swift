//
//  OLDDeck.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/12/23.
//

import Foundation
import SwiftUI


struct OLDDeck: Codable {
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

extension OLDDeck {
    static func newOLDDeck() -> OLDDeck {
        var OLDDeck = OLDDeck()
        OLDDeck.createNewPile()
        OLDDeck.shuffle()
        return OLDDeck
    }
    
    static func testOLDDeck() -> OLDDeck {
        var OLDDeck = OLDDeck.newOLDDeck()
        while OLDDeck.pile.count > 2 {
            OLDDeck.pile.removeFirst()
        }
        return OLDDeck
    }
}
