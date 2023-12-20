//
//  Lobby.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/13/23.
//

import Foundation


struct Lobby {
    var players: [Player]
    
    init(players: [Player]) {
        self.players = players
    }
    
    
    mutating func shufflePlayerOrder() {
        var updatedPlayers = self.players.shuffled()
        for i in updatedPlayers.indices {
            updatedPlayers[i].index = i
        }
        self.players = updatedPlayers
    }
    mutating func setupResultsData() {
        let playerPointsArr = self.players.map({PlayerPoints(player: $0)})
        
        for i in self.players.indices {
            self.players[i].givenTo = playerPointsArr
            self.players[i].takenFrom = playerPointsArr
        }
    }
    mutating func dealCards(completionHandler: @escaping ([Card]) -> Void) {
        var dealtOutDeck = Card.newDeck()
        
        for i in self.players.indices {
            while self.players[i].hand.count < 4 {
                self.players[i].hand.append(dealtOutDeck[0])
                dealtOutDeck.removeFirst()
            }
        }
        completionHandler(dealtOutDeck)
    }
}

extension Lobby {
    static var previewGameHasStarted = Lobby(players: Player.previewGameHasStarted)
    static var previewResults = Lobby(players: Player.previewResults)
}







extension Lobby: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.players = try container.decodeIfPresent([Player].self, forKey: .players) ?? []
    }
    
    enum CodingKeys: CodingKey {
        case players
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.players, forKey: .players)
    }
}
