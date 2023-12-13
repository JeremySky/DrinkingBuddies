//
//  GameViewModel.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/5/23.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift







//MARK: -- VIEW MODEL
@MainActor
@dynamicMemberLookup
class OLDGameViewModel: ObservableObject {
    @Published var game = OLDGame()
    var gameRoomID: String
    var player: Player
    private var refHandle: DatabaseHandle!
    @Published var gameViewSelection: GameViewSelection = .local
    @Published var setupSelection: SetupSelection = .main
    
    
    var ref = Database.database().reference()
    
    func createNewGame() {
        self.game.host = player
        ref.child(gameRoomID).setValue(game.toDictionary)
        joinGame(id: gameRoomID)
    }
    
    func observeGame() {
        ref.child(gameRoomID)
            .observe(.value) { snapshot in
                do {
                    self.game = try snapshot.data(as: OLDGame.self)
                } catch {
                    print("Cannot convert to Game")
                }
            }
    }
    
    func joinGame(id: String) {
        gameRoomID = id
        var hasJoined = false
        
        ref.child(gameRoomID)
            .observe(.value) { snapshot in
                do {
                    self.game = try snapshot.data(as: OLDGame.self)
                    if !hasJoined {
                        self.ref.child("\(self.gameRoomID)/players/\(self.game.players.count)").setValue(self.player.toDictionary)
                        hasJoined = true
                    }
                } catch {
                    print("Cannot convert to Game")
                }
            }
    }
    
    
    func leaveGame() {
        self.game.players.remove(at: player.index)
        ref.child(gameRoomID).setValue(game.toDictionary)
        ref.child(gameRoomID).removeObserver(withHandle: refHandle)
        self.game = OLDGame()
    }
    
    func deleteGame() {
        ref.child(gameRoomID).removeValue()
    }
    
    
    
    
    
    
    
    
    init(game: OLDGame = OLDGame(), gameRoomID: String = String.randomRoomID(), player: Player = Player()) {
        self.game = game
        self.gameRoomID = gameRoomID
        self.player = player
    }
//    init(players: [Player], deck: Deck, gameRoomID: String, player: Player) {
//        let playersShuffled = players.shuffled()
//        var tempPlayer: Player? = nil
//        var playersSetUp = [Player]()
//        
//        for i in playersShuffled.indices {
//            tempPlayer = playersShuffled[i]
//            if tempPlayer != nil {
//                tempPlayer!.setUp(from: playersShuffled, index: i)
//                playersSetUp.append(tempPlayer!)
//                tempPlayer = nil
//            }
//        }
//        
//        var playersShuffledAndSetUp = playersSetUp
//        playersShuffledAndSetUp[0].stage = .guess
//        
//        
//        self.game = Game(deck: deck, players: playersShuffledAndSetUp, currentPlayer: playersShuffledAndSetUp[0], waitingRoom: playersShuffledAndSetUp)
//        self.gameRoomID = gameRoomID
//        self.player = player
//    }
    
    subscript<T>(dynamicMember keyPath: WritableKeyPath<OLDGame, T>) -> T {
        get { game[keyPath: keyPath] }
        set { game[keyPath: keyPath] = newValue }
    }
    
    
    func deal() {
        for i in game.players.indices {
            while game.players[i].hand.count < 4 {
                game.players[i].hand.append(game.deck.pile[0])
                game.deck.pile.removeFirst()
            }
        }
    }
    
    func endGame() {
        for i in game.waitingRoom.indices {
            game.waitingRoom[i].stage = .end
        }
    }
    
    func updateQuestion() {
        if game.phase == .guessing && game.players[0].id == game.waitingRoom[0].id {
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
        game.waitingRoom.append(game.currentPlayer)
        game.waitingRoom.removeFirst()
        game.currentPlayer = game.waitingRoom[0]
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
