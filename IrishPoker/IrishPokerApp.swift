//
//  IrishPokerApp.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/11/23.
//

import SwiftUI

@main
struct IrishPokerApp: App {
    var body: some Scene {
        WindowGroup {
            PlayerHandView(hand: [
                PlayingCard(value: .six, suit: .clubs),
                PlayingCard(value: .eight, suit: .clubs),
                PlayingCard(value: .seven, suit: .diamonds),
                PlayingCard(value: .ten, suit: .spades)
            ], question: .four, cardSelection: .four)
        }
    }
}
