//
//  GameView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/14/23.
//

import SwiftUI

//MARK: -- VIEW MODEL
@MainActor
@dynamicMemberLookup
class GameViewModel: ObservableObject {
    @Published var game: Game
    @Published var currentPlayer: Player
    @Published var waitingRoom: [Player]
    @Published var turnTaken = false
    
    init(players: [Player]) {
        var shuffledPlayers = players.shuffled()
        shuffledPlayers[0].stage = .guess
        
        self.game = Game(players: shuffledPlayers)
        self.currentPlayer = shuffledPlayers[0]
        self.waitingRoom = shuffledPlayers
    }
    
    subscript<T>(dynamicMember keyPath: WritableKeyPath<Game, T>) -> T {
        get { game[keyPath: keyPath] }
        set { game[keyPath: keyPath] = newValue }
    }
    
    
    func updateQuestion() {
        if game.phase == .guessing {
            switch game.question {
            case .one:
                game.question = .two
            case .two:
                game.question = .three
            case .three:
                game.question = .four
            case .four:
                game.phase = .giveTake
            }
        }
    }
    
    func updateCurrentPlayer() {
        waitingRoom.append(currentPlayer)
        waitingRoom.removeFirst()
        currentPlayer = waitingRoom[0]
    }
    
    func checkForGive(_ card: Card) {
        for playerIndex in game.players.indices {
            for cardIndex in game.players[playerIndex].hand.indices {
                if game.players[playerIndex].hand[cardIndex].value == card.value {
                    game.players[playerIndex].pointsToGive += card.value.rawValue
                }
            }
        }
    }
    
    func checkForTake(_ card: Card) {
        for playerIndex in game.players.indices {
            for cardIndex in game.players[playerIndex].hand.indices {
                if game.players[playerIndex].hand[cardIndex].value == card.value {
                    game.players[playerIndex].pointsToTake += card.value.rawValue
                }
            }
        }
    }
    
    func updateDeck() {
        if game.phase == .giveTake {
            game.deck.pile.removeFirst()
            game.deck.pile.removeFirst()
        }
    }
}


//MARK: -- VIEW
struct GameView: View {
    @StateObject var game: GameViewModel
    @State var selection: GameViewSelection
    
    var body: some View {
        switch selection {
        case .local:
            LocalGameView()
                .environmentObject(game)
        case .remoteBluetooth, .remoteWifi:
            PlayerView(player: .constant(Player.test1))
                .environmentObject(game)
        }
    }
}


enum GameViewSelection {
    case local
    case remoteBluetooth
    case remoteWifi
}


#Preview {
    GameView(game: GameViewModel.preview, selection: .local)
}





extension GameViewModel {
    static var preview = GameViewModel(players: Player.testArr)
}
