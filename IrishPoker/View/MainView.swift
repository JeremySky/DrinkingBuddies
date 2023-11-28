//
//  MainView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/20/23.
//

import SwiftUI

@MainActor
class SetupViewModel: ObservableObject {
    @Published var player: Player = Player()
    @Published var players: [Player] = []
    @Published var gameViewSelection: GameViewSelection = .local
    @Published var deck: Deck = Deck.newDeck()
    
    init(player: Player = Player(), players: [Player] = [], gameViewSelection: GameViewSelection = .local, deck: Deck = Deck.newDeck()) {
        self.player = player
        self.players = players
        self.gameViewSelection = gameViewSelection
        self.deck = deck
    }
    
    func deal() {
        for i in players.indices {
            while players[i].hand.count < 4 {
                players[i].hand.append(deck.pile[0])
                deck.pile.removeFirst()
            }
        }
    }
}

struct MainView: View {
    @State var settings: SetupViewModel
    @State var selection: AppViewSelection = .setup
    
    var body: some View {
        switch selection {
        case .setup:
            NavigationStack {
                SetupView() {
                    settings.deal()
                    selection = .game
                }
            }
            .environmentObject(settings)
        case .game:
            GameView(game: GameViewModel(players: settings.players, deck: settings.deck), selection: settings.gameViewSelection)
        }
    }
    
    enum AppViewSelection {
        case setup
        case game
    }
}

#Preview {
    MainView(settings: SetupViewModel())
}

//for user defaults
struct User: Codable {
    let name: String
    let icon: IconSelection
    let color: ColorSelection
}
