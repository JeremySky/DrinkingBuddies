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
//            PlayersTurnView(player: Player.test1, card: Card.test1, question: .one) { _ in }
//            GameView(game: GameViewModel(players: [Player.test1, Player.test2, Player.test3, Player.test4]))
//            CustomColorPicker(selectedColor: .constant(.red))
            MainView()
        }
    }
}
