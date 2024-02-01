//
//  GameManager.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/11/23.
//

import Foundation

@MainActor
@dynamicMemberLookup
class GameManager: ObservableObject {
    @Published var game: Game
    @Published var user: User
    @Published var stage: Stage
    private var repository: GameRepository
    
    init(game: Game, user: User, repository: GameRepository, stage: Stage = .waiting) {
        self.game = game
        self.user = user
        self.repository = repository
        self.stage = stage
    }
    
    init(user: User) {
        let randomID = String.randomGameID()
        self.game = Game(user: user, gameID: randomID)
        self.user = user
        self.repository = GameRepository(user: user, gameID: randomID)
        self.stage = .waiting
    }
    
    subscript<T>(dynamicMember keyPath: WritableKeyPath<Game, T>) -> T {
        get { game[keyPath: keyPath] }
        set { game[keyPath: keyPath] = newValue }
    }
    
    
    
    
    //MARK: -- CREATING NEW GAME & JOINING GAME & LEAVING GAME
    func createNewGame() {
        resetManagerAndRepo()
        Task {
            await createUniqueID {
                self.repository.setNewGame(self.game)
                self.repository.observeGame { result in
                    self.handleGameResult(result)
                }
            }
        }
    }
    func createUniqueID(completion: @escaping () -> Void) async {
        do {
            let exists = try await repository.checkGameIDExists().get()
            
            if exists {
                print("GameID already exists, try again")
                resetManagerAndRepo()
                await createUniqueID(completion: completion)
            } else {
                print("GameID Unique, continue")
                completion()
            }
        } catch {
            print("Error checking game ID:", error.localizedDescription)
            // Handle the error as needed, e.g., retry or show an alert
        }
    }
    //WIP joingGame(_:) needs to throws
    func didJoinGame(_ gameID: String, completion: @escaping (Bool) -> Void ) {
        Task {
            do {
                game.id = gameID
                repository.updateGameID(to: gameID)
                
                let exists = try await repository.checkGameIDExists().get()
                
                if exists {
                    print("GameID exists, join")
                    repository.observeGame { result in
                        self.handleGameResult(result)
                    }
                    repository.addPlayer()
                    completion(true)
                } else {
                    print("GameID does not exist, enter an existing ID and try again")
                    // Handle the error as needed, e.g., retry or show an alert
                    completion(false)
                }
            } catch {
                print("Error checking game ID:", error.localizedDescription)
                // Handle the error as needed, e.g., retry or show an alert
                completion(false)
            }
        }
    }
    func leaveGame() {
        removeSelfFromGame()
        repository.stopObserving()
    }
    
    
    //MARK: -- GAME SETUP $ GAME START
    func setupLobby() -> Lobby {
        var newLobby = game.lobby
        newLobby.shufflePlayerOrder()
        newLobby.setupResultsData()
        newLobby.dealCards { [weak self] updatedDeck in
            self?.repository.updateDeck(to: updatedDeck)
        }
        
        return newLobby
    }
    func startGame() {
        self.repository.updateLobby(to: setupLobby())
        self.repository.updateHasStarted(to: true)
    }
    func updateUserIndex() {
        let players = game.lobby.players
        for i in players.indices {
            if user.id == players[i].id {
                user.index = i
            }
        }
    }
    
    
    //MARK: -- GENERAL UPDATE GAME
    func flipCard() {
        repository.updatePlayerCardFlipState(playerIndex: user.index, cardIndex: game.question.number - 1)
    }
    func resetTurnTaken() {
        repository.updateTurnTaken(to: false)
    }
    func updateStage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) { [self] in
            if !game.turnTaken {
                if self.user.id == self.game.lobby.players[game.currentPlayerIndex].id {
                    self.stage = .guessing
                } else {
                    self.stage = .waiting
                }
            } else {
                if checkUserPointsToGive() {
                    self.stage = .giving
                } else if checkUserPointsToTake() {
                    self.stage = .taking
                } else if checkAllPlayersForGiveOrTake() && user.id == game.lobby.players[game.currentPlayerIndex].id {
                    
                    repository.updateTurnTaken(to: false)
                    updateCurrentPlayer()
                    updateQuestion()
                    
                } else {
                    self.stage = .waiting
                }
            }
        }
    }
    func updateCurrentPlayer() {
        var updatedIndex = game.currentPlayerIndex
        updatedIndex = (updatedIndex + 1) % game.lobby.players.count
        repository.updateCurrentPlayerIndex(to: updatedIndex)
        game.currentPlayerIndex = updatedIndex
    }
    
    func checkForGameEnd() -> Bool {
        if game.deck.pile.count < 2 && checkAllPlayersForGiveOrTake() {
            endGame()
            return true
        } else {
            return false
        }
    }
    func endGame() {
        repository.updatePhase(to: .results)
    }
    func checkUserPointsToGive() -> Bool {
        var result: Bool = false
        for i in game.lobby.players.indices {
            if user.id == game.lobby.players[i].id {
                result = game.lobby.players[i].pointsToGive > 0
            }
        }
        return result
    }
    func checkUserPointsToTake() -> Bool {
        var result: Bool = false
        for i in game.lobby.players.indices {
            if user.id == game.lobby.players[i].id {
                result = game.lobby.players[i].pointsToTake > 0
            }
        }
        return result
    }
    
    
    //MARK: -- GUESSING PHASE
    func setResultsOfGuessing(_ result: Bool, _ points: Int) {
        var updatedPlayer = fetchUsersPlayerReference()
        if result {
            updatedPlayer.pointsToGive = points
        } else {
            updatedPlayer.pointsToTake = points
        }
        updatedPlayer.guesses.append(result)
        repository.updatePlayer(at: user.index, to: updatedPlayer)
        turnCompleted()
        
        updateStage()
    }
    func turnCompleted() {
        repository.updateTurnTaken(to: true)
    }
    func updateQuestion() {
        if game.currentPlayerIndex == 0 && game.phase == .guessing {
            switch game.question {
            case .one:
                repository.updateQuestion(to: .two)
            case .two:
                repository.updateQuestion(to: .three)
            case .three:
                repository.updateQuestion(to: .four)
            case .four:
                repository.updatePhase(to: .giveTake)
            }
        }
    }
    
    
    //MARK: -- GIVE/TAKE PHASE
    func setResultsOfGiveTake() {
        repository.updateTurnTaken(to: true)
        self.stage = .waiting
        removeTwoCards()
    }
    func checkForGiveAndTake(_ card: Card, _ firstPick: inout CardValue?, _ secondPick: inout CardValue?) {
        if firstPick == nil {
            checkPlayersHandForGive(matching: card)
            firstPick = card.value
        } else {
            checkPlayersHandForTake(matching: card)
            secondPick = card.value
        }
    }
    func checkPlayersHandForGive(matching card: Card) {
        let players = game.lobby.players
        for playerIndex in players.indices {
            let hand = players[playerIndex].hand
            for cardIndex in hand.indices {
                if hand[cardIndex].value == card.value {
                    var updatedPlayer = players[playerIndex]
                    updatedPlayer.pointsToGive += card.value.rawValue
                    updatedPlayer.hand[cardIndex].giveCards.append(card)
                    
                    repository.updatePlayer(at: playerIndex, to: updatedPlayer)
                }
            }
        }
    }
    func checkPlayersHandForTake(matching card: Card) {
        let players = game.lobby.players
        for playerIndex in players.indices {
            let hand = players[playerIndex].hand
            for cardIndex in hand.indices {
                if hand[cardIndex].value == card.value {
                    var updatedPlayer = players[playerIndex]
                    updatedPlayer.pointsToTake += card.value.rawValue
                    updatedPlayer.hand[cardIndex].takeCards.append(card)
                    
                    repository.updatePlayer(at: playerIndex, to: updatedPlayer)
                }
            }
        }
    }
    func removeTwoCards() {
        repository.removeTwoCards(from: game.deck)
    }
    
    
    //MARK: -- GIVE STAGE
    //WIP UPDATE NEEDS TO BE MORE DIRECT
    // a == pointer, b == repo
    // 1) update user's pointsToGive check ✓
    // 2) update user's GivenTo ✓
    // 3) update player's pointsToTake ✓
    // 4) update player's TakenFrom ✓
    func givePointsTo(_ lobby: Lobby, pointsGiven: Int) {
        // 1a & 3a resolved prior
        var updatedLobby = lobby
        // 1b) update user's pointsToGive
        repository.updatePointsToGive(at: user.index, subtract: pointsGiven)
        
        for playerIndex in updatedLobby.players.indices {
            
            // 2a)update user's givenTo
            updatedLobby.players[user.index].give(points: updatedLobby.players[playerIndex].pointsToTake, to: updatedLobby.players[playerIndex].id)
            
            // 3b) update player's pointsToTake
            repository.updatePointsToTake(at: playerIndex, add: updatedLobby.players[playerIndex].pointsToTake)
            
            // 4a) update player's takenFrom
            updatedLobby.players[playerIndex].take(points: updatedLobby.players[playerIndex].pointsToTake, from: user.id)
            // 4b) update player's takenFrom
            repository.updateTakenFrom(to: updatedLobby.players[playerIndex])
        }
        
        // 2b)update user's givenTo
        repository.updateGivenTo(updatedLobby.players[user.index])
        
        
        updateStage()
        
        
    }
    
    
    //MARK: -- GIVE STAGE
    func takePoints(_ points: Int, completionHandler: ((Int?) -> Void)) {
        var updatedPlayer = fetchUsersPlayerReference()
        var pointsToTake: Int?
        updatedPlayer.pointsToTake -= points
        
        
        
        if updatedPlayer.pointsToTake > 0 {
            pointsToTake = updatedPlayer.pointsToTake
        } else {
            self.stage = .waiting
            pointsToTake = nil
        }
        
        repository.updatePlayer(at: user.index, to: updatedPlayer)
        completionHandler(pointsToTake)
    }
}













//MARK -- HELPER FUNCTIONS
extension GameManager {
    func checkAllPlayersForGiveOrTake() -> Bool {
        !game.lobby.players.map({ $0.pointsToGive == 0 && $0.pointsToTake == 0 }).contains(false)
    }
    func handleGameResult(_ result: Result<Game, Error>) {
        switch result {
        case .success(let game):
            self.game = game
        case .failure(let error):
            //WIP Alert
            print("Error observing game: \(error)")
        }
    }
    func fetchUsersPlayerReference() -> Player {
        game.lobby.players[user.index]
    }
    func fetchPlayerCard(at index: Int) -> Card {
        fetchUsersPlayerReference().hand[index]
    }
    func updateUser(to user: User) {
        self.user = user
        let newGameID = String.randomGameID()
        self.game = Game(user: user, gameID: newGameID)
        self.repository.gameID = newGameID
    }
    
    
    
    func removeSelfFromGame() {
        var newPlayers = game.lobby.players
        newPlayers.removeAll { player in
            return user == player.user
        }
        let newLobby = Lobby(players: newPlayers)
        repository.updateLobby(to: newLobby)
        
        if user == game.host {
            replaceHost(using: newLobby)
        }
    }
    
    func replaceHost(using newLobby: Lobby) {
        guard let newHost = newLobby.players.first?.user else {
            repository.deleteGame()
            return
        }
        game.host = newHost
        repository.updateHost(to: newHost)
    }
    
    func resetManagerAndRepo() {
        let newGameID = String.randomGameID()
        self.game = Game(user: self.user, gameID: newGameID)
        repository.updateGameID(to: newGameID)
    }
}


//MARK: -- PREVIEWS
extension GameManager {
    static var previewSetUp = GameManager(user: User.test1)
    static var previewGameStarted = GameManager(game: Game.previewGameHasStarted, user: User.test1, repository: GameRepository(user: User.test1, gameID: Game.testRoomID))
    static var previewResults = GameManager(game: Game.previewResults, user: User.test1, repository: GameRepository(user: User.test1, gameID: Game.testRoomID))
    static var previewPlayerTakes: GameManager {
        let game = GameManager(game: Game.previewGameHasStarted, user: User.test1, repository: GameRepository(user: User.test1, gameID: Game.testRoomID))
        
        for playerIndex in game.lobby.players.indices {
            if game.user.id == game.lobby.players[playerIndex].id {
                game.lobby.players[playerIndex].pointsToTake = 3
            }
        }
        
        
        return game
    }
}
