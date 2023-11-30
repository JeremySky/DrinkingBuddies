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
    
    init(players: [Player], deck: Deck) {
        let playersShuffled = players.shuffled()
        var tempPlayer: Player? = nil
        var playersSetUp = [Player]()
        
        for i in playersShuffled.indices {
            tempPlayer = playersShuffled[i]
            if tempPlayer != nil {
                tempPlayer!.setUp(from: playersShuffled, index: i)
                playersSetUp.append(tempPlayer!)
                tempPlayer = nil
            }
        }
        
        var playersShuffledAndSetUp = playersSetUp
        playersShuffledAndSetUp[0].stage = .guess
        
        
        self.game = Game(deck: deck, players: playersShuffledAndSetUp)
        self.currentPlayer = playersShuffledAndSetUp[0]
        self.waitingRoom = playersShuffledAndSetUp
    }
    
    subscript<T>(dynamicMember keyPath: WritableKeyPath<Game, T>) -> T {
        get { game[keyPath: keyPath] }
        set { game[keyPath: keyPath] = newValue }
    }
    
    func endGame() {
        for i in waitingRoom.indices {
            waitingRoom[i].stage = .end
        }
    }
    
    func updateQuestion() {
        if game.phase == .guessing && game.players[0].id == waitingRoom[0].id {
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
        if game.deck.pile.count < 2 {
            game.phase = .end
        }
        waitingRoom.append(currentPlayer)
        waitingRoom.removeFirst()
        currentPlayer = waitingRoom[0]
    }
    
    func checkForGive(_ card: Card) {
        for playerIndex in game.players.indices {
            for cardIndex in game.players[playerIndex].hand.indices {
                if game.players[playerIndex].hand[cardIndex].value == card.value {
                    game.players[playerIndex].pointsToGive += card.value.rawValue
                    
                    //add card to player's card.giveCards array for results
                    game.players[playerIndex].hand[cardIndex].giveCards.append(card)
                }
            }
        }
    }
    
    func checkForTake(_ card: Card) {
        for playerIndex in game.players.indices {
            for cardIndex in game.players[playerIndex].hand.indices {
                if game.players[playerIndex].hand[cardIndex].value == card.value {
                    game.players[playerIndex].pointsToTake += card.value.rawValue
                    
                    //add card to player's card.takeCards array for results
                    game.players[playerIndex].hand[cardIndex].takeCards.append(card)
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
    static var preview = GameViewModel(players: Player.testArr, deck: Deck.newDeck())
}
