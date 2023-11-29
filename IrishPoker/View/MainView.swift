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
    @Published var mainSelection: AppViewSelection = .setup
    
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
    
    var body: some View {
        switch settings.mainSelection {
        case .setup:
            NavigationStack {
                SetupView() {
                    settings.deal()
                    settings.mainSelection = .game
                }
            }
            .environmentObject(settings)
        case .game:
            GameView(game: GameViewModel(players: settings.players, deck: settings.deck), selection: settings.gameViewSelection)
                .environmentObject(settings)
        }
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


enum AppViewSelection {
    case setup
    case game
}
