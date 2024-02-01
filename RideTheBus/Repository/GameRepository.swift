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
    func checkGameIDExists() async -> Result<Bool, Error> {
        do {
            let snapshot = try await reference.child(gameID).getData()
            return .success(snapshot.exists())
        } catch {
            return .failure(error)
        }
    }
    func setNewGame(_ game: Game) {
        reference.child(gameID).setValue(game.toDictionary)
    }
    func observeGame(completion: @escaping (Result<Game, Error>) -> Void) {
        reference.child(gameID).observe(.value) { snapshot in
            do {
                let game = try snapshot.data(as: Game.self)
                completion(.success(game))
            } catch {
                completion(.failure(AppError.noData))
            }
        }
    }
    func addPlayer() {
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
    func updatePointsToGive(at userIndex: Int, subtract points: Int) {
        let pointsToSubtract = -points
        let pointsToSubtractNSNumber = NSNumber(value: pointsToSubtract)
        let updates = [
            "\(gameID)/lobby/players/\(userIndex)/pointsToGive" : ServerValue.increment(pointsToSubtractNSNumber)
        ] as [String : Any]
        
        reference.updateChildValues(updates)
        
//        reference.updateChildValues(["\(gameID)/lobby/players/\(userIndex)/pointsToGive" : ServerValue.increment(pointsToSubtract as NSNumber)])
    }
    func updateGivenTo(_ player: Player) {
        reference.child("\(gameID)/lobby/players/\(player.index)/givenTo").setValue(player.givenTo.toDictionary)
    }
    func updatePointsToTake(at playerIndex: Int, add points: Int) {
        let points: NSNumber = points as NSNumber
        let updates = [
            "\(gameID)/lobby/players/\(playerIndex)/pointsToTake" : ServerValue.increment(points)
        ] as [String : Any]
        
        reference.updateChildValues(updates)
        
    }
    func updateTakenFrom(to player: Player) {
        reference.child("\(gameID)/lobby/players/\(player.index)/takenFrom").setValue(player.givenTo.toDictionary)
    }
    
    
    
    
    
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

enum AppError: String, Error {
    case noData = "Game with given ID does not exist."
}
