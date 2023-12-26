//
//  GameRepository.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/12/23.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift


struct GameRepository {
    var user: User
    var gameID: String
    var reference = Database.database().reference()
    
    
    //MARK: -- NEW GAME / JOINING
    func setNewGame(_ game: Game) {
        reference.child(gameID).setValue(game.toDictionary)
    }
    func observeGame(completion: @escaping (Result<Game, Error>) -> Void) {
        reference.child(gameID).observe(.value) { snapshot in
            do {
                guard snapshot.exists() else {
                    completion(.failure(FirebaseError.noData))
                    return
                }
                let game = try snapshot.data(as: Game.self)
                completion(.success(game))
            } catch {
                print("Cannot convert to Game: \(error)")
                completion(.failure(FirebaseError.decodingError))
            }
        }
    }
    func joinGame() {
        let playersRef = reference.child("\(gameID)/lobby/players")
        
        playersRef.observeSingleEvent(of: .value) { snapshot in
            let newIndex = Int(snapshot.childrenCount)
            let newChildReference = playersRef.child(String(newIndex))
            newChildReference.setValue(Player(user: self.user).toDictionary)
        }
    }
    
    
    //MARK: - DELETE GAME / LEAVING
    func stopObserving() {
        reference.child(gameID).removeAllObservers()
    }
    
    func deleteGame() {
        reference.child(gameID).removeValue()
    }
    
    
    
    //MARK: -- UPDATE GAME PROPERTIES
    func updateHost(to updatedHost: User) {
        reference.child("\(gameID)/host").updateChildValues(updatedHost.toDictionary!)
    }
    func updateLobby(to updatedLobby: Lobby) {
        reference.child("\(gameID)/lobby").updateChildValues(updatedLobby.toDictionary!)
    }
    func updatePlayer(at userIndex: Int, to updatedPlayer: Player) {
        reference.child("\(gameID)/lobby/players/\(userIndex)").updateChildValues(updatedPlayer.toDictionary!)
    }
    func updateDeck(to updatedDeck: Deck) {
        reference.child("\(gameID)/deck").updateChildValues(updatedDeck.toDictionary!)
    }
    func removeTwoCards(from deck: Deck) {
        reference.child("\(gameID)/deck/pile/\(deck.pile.count - 1)").removeValue()
        reference.child("\(gameID)/deck/pile/\(deck.pile.count - 2)").removeValue()
    }
    func updateHasStarted(to hasStarted: Bool) {
        reference.child("\(gameID)/hasStarted").setValue(hasStarted)
    }
    func updateTurnTaken(to turnTaken: Bool) {
        reference.child("\(gameID)/turnTaken").setValue(turnTaken)
    }
    func updateQuestion(to newQuestion: Question) {
        reference.child("\(gameID)/question").setValue(newQuestion.rawValue)
    }
    func updatePhase(to newPhase: Phase) {
        reference.child("\(gameID)/phase").setValue(newPhase.rawValue)
    }
    func updateCurrentPlayerIndex(to updatedIndex: Int) {
        reference.child("\(gameID)/currentPlayerIndex").setValue(updatedIndex)
    }
    func updatePlayerCardFlipState(playerIndex: Int, cardIndex: Int) {
        reference.child("\(gameID)/lobby/players/\(playerIndex)/hand/\(cardIndex)/isFlipped").setValue(true)
    }
}




extension GameRepository {
    mutating func updateGameID(to newID: String) {
        self.gameID = newID
    }
}

enum FirebaseError: Error {
    case noData
    case decodingError
}
