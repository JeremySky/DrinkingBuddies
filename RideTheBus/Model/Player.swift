//
//  Player.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/11/23.
//

import Foundation

enum Stage: String, RawRepresentable, Codable {
    case guessing
    case giving
    case taking
    case waiting
}

@dynamicMemberLookup
struct Player {
    var user: User
    var hand: [Card]
    
    //MARK: -- Results
    var score: Int
    var guesses: [Bool]
    var givenTo: [PlayerPoints]
    var takenFrom: [PlayerPoints]
    
    //MARK: -- Changing stages
    var pointsToGive: Int
    var pointsToTake: Int

    
    init(user: User, hand: [Card] = [], score: Int = 0, guesses: [Bool] = [], giveTo: [PlayerPoints] = [], takeFrom: [PlayerPoints] = [], pointsToGive: Int = 0, pointsToTake: Int = 0) {
        self.user = user
        self.hand = hand
        self.score = score
        self.guesses = guesses
        self.givenTo = giveTo
        self.takenFrom = takeFrom
        self.pointsToGive = pointsToGive
        self.pointsToTake = pointsToTake
    }
    

    subscript<T>(dynamicMember keyPath: WritableKeyPath<User, T>) -> T {
        get { user[keyPath: keyPath] }
        set { user[keyPath: keyPath] = newValue }
    }
    
    mutating func reset() {
        self.hand = []
        self.score = 0
        self.guesses = []
        self.givenTo = []
        self.takenFrom = []
        self.pointsToGive = 0
        self.pointsToTake = 0
    }
    
    mutating func give(points: Int, to playerID: UUID) {
        for i in givenTo.indices {
            if playerID == givenTo[i].userID {
                givenTo[i].points += points
            }
        }
    }
    
    mutating func take(points: Int, from playerID: UUID) {
        for i in takenFrom.indices {
            if playerID == takenFrom[i].userID {
                takenFrom[i].points += points
            }
        }
    }
}

extension Player {
    static var previewGameHasStarted = User.testArr.map({Player(user: $0, hand: Card.randomHand(), score: 0, guesses: [], giveTo: User.testArr.map({PlayerPoints(userID: $0.id)}), takeFrom:  User.testArr.map({PlayerPoints(userID: $0.id)}), pointsToGive: 0, pointsToTake: 0)})
    
    static var previewWithPoints = Player(user: User.test1, hand: Card.testHandArray1, score: 0, guesses: [], giveTo: [], takeFrom: [], pointsToGive: 1, pointsToTake: 0)
    
    static var previewResults: [Player] {
        var players = User.testArr.map({Player(user: $0, hand: Card.randomHand(), score: 0, guesses: [], giveTo: User.testArr.map({PlayerPoints(userID: $0.id)}), takeFrom:  User.testArr.map({PlayerPoints(userID: $0.id)}), pointsToGive: 0, pointsToTake: 0)})
        
        players[0].hand = Card.testHandArrayResults
        players[0].guesses = [true, true, false, false]
        players[0].givenTo[0].points = 23
        players[0].givenTo[1].points = 34
        players[0].givenTo[2].points = 24
        players[0].givenTo[3].points = 120
        players[0].takenFrom[0].points = 23
        players[0].takenFrom[1].points = 34
        players[0].takenFrom[2].points = 24
        players[0].takenFrom[3].points = 120
        players[0].score = 123
        
        players[1].hand = Card.hand1
        players[1].guesses = [false, true, false, false]
        players[1].givenTo[0].points = 23
        players[1].givenTo[1].points = 34
        players[1].givenTo[2].points = 24
        players[1].givenTo[3].points = 120
        players[1].takenFrom[0].points = 23
        players[1].takenFrom[1].points = 34
        players[1].takenFrom[2].points = 24
        players[1].takenFrom[3].points = 120
        players[1].score = 123
        
        players[2].hand = Card.hand1
        players[2].guesses = [true, true, false, true]
        players[2].givenTo[0].points = 23
        players[2].givenTo[1].points = 34
        players[2].givenTo[2].points = 24
        players[2].givenTo[3].points = 120
        players[2].takenFrom[0].points = 23
        players[2].takenFrom[1].points = 34
        players[2].takenFrom[2].points = 24
        players[2].takenFrom[3].points = 120
        players[2].score = 123
        
        players[3].hand = Card.hand1
        players[3].guesses = [true, true, true, false]
        players[3].givenTo[0].points = 23
        players[3].givenTo[1].points = 34
        players[3].givenTo[2].points = 24
        players[3].givenTo[3].points = 120
        players[3].takenFrom[0].points = 23
        players[3].takenFrom[1].points = 34
        players[3].takenFrom[2].points = 24
        players[3].takenFrom[3].points = 120
        players[3].score = 123
        
        return players
    }
}








extension Player: Hashable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.user == rhs.user &&
        lhs.hand == rhs.hand &&
        lhs.score == rhs.score &&
        lhs.guesses == rhs.guesses &&
        lhs.givenTo == rhs.givenTo &&
        lhs.takenFrom == rhs.takenFrom &&
        lhs.pointsToGive == rhs.pointsToGive &&
        lhs.pointsToTake == rhs.pointsToTake
    }
}


extension Player: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.user = try container.decode(User.self, forKey: .user)
        self.hand = try container.decodeIfPresent([Card].self, forKey: .hand) ?? []
        self.score = try container.decode(Int.self, forKey: .score)
        self.guesses = try container.decodeIfPresent([Bool].self, forKey: .guesses) ?? []
        self.givenTo = try container.decodeIfPresent([PlayerPoints].self, forKey: .giveTo) ?? []
        self.takenFrom = try container.decodeIfPresent([PlayerPoints].self, forKey: .takeFrom) ?? []
        self.pointsToGive = try container.decode(Int.self, forKey: .pointsToGive)
        self.pointsToTake = try container.decode(Int.self, forKey: .pointsToTake)
    }
    
    enum CodingKeys: CodingKey {
        case user
        case hand
        case score
        case guesses
        case giveTo
        case takeFrom
        case pointsToGive
        case pointsToTake
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.user, forKey: .user)
        try container.encode(self.hand, forKey: .hand)
        try container.encode(self.score, forKey: .score)
        try container.encode(self.guesses, forKey: .guesses)
        try container.encode(self.givenTo, forKey: .giveTo)
        try container.encode(self.takenFrom, forKey: .takeFrom)
        try container.encode(self.pointsToGive, forKey: .pointsToGive)
        try container.encode(self.pointsToTake, forKey: .pointsToTake)
    }
}

