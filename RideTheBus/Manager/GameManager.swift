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
    private var user: User
    
    init(user: User) {
        self.game = Game(user: user)
        self.user = user
    }
    
    subscript<T>(dynamicMember keyPath: WritableKeyPath<Game, T>) -> T {
        get { game[keyPath: keyPath] }
        set { game[keyPath: keyPath] = newValue }
    }
    
    
    //MARK: -- GAME SETUP
    func shufflePlayerOrder() {
        game.players = game.players.shuffled()
    }
    func setupResultsData() {
        var playerPointsArr = game.players.map({PlayerPoints(player: $0)})
        
        for i in game.players.indices {
            game.players[i].givenTo = playerPointsArr
            game.players[i].takenFrom = playerPointsArr
        }
    }
    func deal() {
        for i in game.players.indices {
            while game.players[i].hand.count < 4 {
                game.players[i].hand.append(game.deck[0])
                game.deck.removeFirst()
            }
        }
    }
    func setupGame() {
        shufflePlayerOrder()
        setupResultsData()
        deal()
    }
    //MARK: -- START GAME
    func startGame() {
        game.hasStarted = true
    }
    
    
    //MARK: -- GENERAL UPDATE GAME
    func updateGame(card: Card?) {
        switch game.phase {
        case .guessing:
            updateQuestion()
            updateCurrentPlayer()
        case .giveTake:
            if let card {
                checkForGive(card)
                checkForTake(card)
                if checkForGameEnd() {
                    endGame()
                } else {
                    removeTwoCards()
                    updateCurrentPlayer()
                }
            }
        case .end:
            game.reset()
        }
    }
    func updateCurrentPlayer() {
        if game.currentPlayerIndex == game.players.count - 1 {
            game.currentPlayerIndex = 0
        } else {
            game.currentPlayerIndex += 1
        }
    }
    func checkForGameEnd() -> Bool {
        if game.deck.count < 2 {
            game.phase = .end
            return true
        } else {
            return false
        }
    }
    func endGame() {
        for i in game.players.indices {
            game.players[i].stage = .end
        }
    }
    
    
    //MARK: -- GUESSING PHASE
    func updateQuestion() {
        if game.players[0].id == game.players[game.currentPlayerIndex].id {
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
    
    
    //MARK: -- GIVE/TAKE PHASE
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
    func removeTwoCards() {
        if game.phase == .giveTake {
            game.deck.removeFirst()
            game.deck.removeFirst()
        }
    }
}
