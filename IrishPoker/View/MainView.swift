//
//  MainView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/20/23.
//

import SwiftUI

struct MainView: View {
    @State var selection: AppViewSelection = .setup
    @State var players: [Player]?
    @State var gameViewSelection: GameViewSelection = .local
    var body: some View {
        switch selection {
        case .setup:
            SetupView(selection: .welcome, gameViewSelection: $gameViewSelection) { players in
                self.players = players
                selection = .game
            }
        case .game:
            if let players {
                GameView(game: GameViewModel(players: players), selection: gameViewSelection)
            }
        }
    }
    
    enum AppViewSelection {
        case setup
        case game
    }
}

#Preview {
    MainView()
}
