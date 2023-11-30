//
//  Game.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/15/23.
//

import Foundation
import SwiftUI

struct Game {
    let id = UUID()
    var deck: Deck
    var players: [Player]
    var phase: GamePhase = .guessing
    var question: Question = .one
}

enum GamePhase {
    case guessing
    case giveTake
    case end
}

enum Question: String, RawRepresentable {
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
