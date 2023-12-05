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
    @Published var setupSelection: SetupSelection = .main
    
    init(player: Player = Player(), players: [Player] = [], gameViewSelection: GameViewSelection = .local, deck: Deck = Deck.newDeck(), mainSelection: AppViewSelection = .setup) {
        self.player = player
        self.players = players
        self.gameViewSelection = gameViewSelection
        self.deck = deck
        self.mainSelection = mainSelection
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
    @ObservedObject var settings: SetupViewModel
    
    var body: some View {
        ZStack {
            switch settings.mainSelection {
            case .setup:
                SetupView()
                    .environmentObject(settings)
            case .game:
                GameView(game: GameViewModel(players: settings.players, deck: Deck.testDeck()), selection: settings.gameViewSelection)
            }
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
