//
//  Deck.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/20/23.
//

import Foundation

struct Deck: Codable {
    var pile: [Card]
    
    init(pile: [Card]) {
        self.pile = pile
    }
}
