//
//  Player.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import Foundation
import SwiftUI


struct OLDPlayer: Codable {
    var id = UUID()
    var name: String
    var icon: IconSelection
    var color: Color
    var hand: [Card]
    var index: Int
    
    //MARK: -- Results
    var score: Int = 0
    var guesses: [Bool] = []
    var giveTo: [Int] = []
    var takeFrom: [Int] = []
    
    
    
    //MARK: -- Changing stages
    var stage: Stage = .waiting
    var pointsToGive: Int = 0
    var pointsToTake: Int = 0
    
    
    init(name: String, icon: IconSelection, color: Color, hand: [Card] = [], index: Int = 0, score: Int = 0, guesses: [Bool] = [], giveTo: [Int] = [], takeFrom: [Int] = [], stage: Stage = .waiting, pointsToGive: Int = 0, pointsToTake: Int = 0) {
        self.name = name
        self.icon = icon
        self.color = color
        self.hand = hand
        self.index = index
        self.score = score
        self.guesses = guesses
        self.giveTo = giveTo
        self.takeFrom = takeFrom
        self.stage = stage
        self.pointsToGive = pointsToGive
        self.pointsToTake = pointsToTake
    }
    
    init() {
        self.init(name: "", icon: .drink, color: .red, hand: [])
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.icon = try container.decode(IconSelection.self, forKey: .icon)
        self.color = try container.decode(Color.self, forKey: .color)
        self.hand = try container.decodeIfPresent([Card].self, forKey: .hand) ?? []
        self.index = try container.decode(Int.self, forKey: .index)
        self.score = try container.decode(Int.self, forKey: .score)
        self.guesses = try container.decodeIfPresent([Bool].self, forKey: .guesses) ?? []
        self.giveTo = try container.decodeIfPresent([Int].self, forKey: .giveTo) ?? []
        self.takeFrom = try container.decodeIfPresent([Int].self, forKey: .takeFrom) ?? []
        self.stage = try container.decode(Stage.self, forKey: .stage)
        self.pointsToGive = try container.decode(Int.self, forKey: .pointsToGive)
        self.pointsToTake = try container.decode(Int.self, forKey: .pointsToTake)
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case icon
        case color
        case hand
        case index
        case score
        case guesses
        case giveTo
        case takeFrom
        case stage
        case pointsToGive
        case pointsToTake
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.icon, forKey: .icon)
        try container.encode(self.color, forKey: .color)
        try container.encode(self.hand, forKey: .hand)
        try container.encode(self.index, forKey: .index)
        try container.encode(self.score, forKey: .score)
        try container.encode(self.guesses, forKey: .guesses)
        try container.encode(self.giveTo, forKey: .giveTo)
        try container.encode(self.takeFrom, forKey: .takeFrom)
        try container.encode(self.stage, forKey: .stage)
        try container.encode(self.pointsToGive, forKey: .pointsToGive)
        try container.encode(self.pointsToTake, forKey: .pointsToTake)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func copyAndRemovePointsToTake() -> OLDPlayer {
        var player = self
        player.pointsToTake = 0
        return player
    }
    
    mutating func setUp(from players: [OLDPlayer], index: Int) {
        for _ in players {
            self.giveTo.append(0)
            self.takeFrom.append(0)
            self.index = index
        }
    }
}


extension OLDPlayer: Hashable, Equatable {
    
    static func == (lhs: OLDPlayer, rhs: OLDPlayer) -> Bool {
        return (
            lhs.name == rhs.name &&
            lhs.icon == rhs.icon &&
            lhs.color == rhs.color &&
            lhs.hand == rhs.hand &&
            lhs.pointsToGive == rhs.pointsToGive &&
            lhs.pointsToTake == rhs.pointsToTake
        )
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(icon)
        hasher.combine(color)
        hasher.combine(hand)
        hasher.combine(pointsToGive)
        hasher.combine(pointsToTake)
    }
    
}




extension OLDPlayer {
    static var test1 = OLDPlayer(name: "Jeremy", icon: .gradCap, color: .blue, hand: Card.testHandArray1)
    static var test2 = OLDPlayer(name: "Sam", icon: .personFrame, color: .green, hand: Card.testHandArray2)
    static var test3 = OLDPlayer(name: "Balto", icon: .idCard, color: .red, hand: Card.testHandArray3)
    static var test4 = OLDPlayer(name: "Trevor", icon: .skateboard, color: .black, hand: Card.testHandArray4)
    
    static var testArr = [test1, test2, test3, test4]
    
    static var take = OLDPlayer(name: "Peter", icon: IconSelection.dumbbell, color: .brown, hand: Card.testHandArray1, pointsToTake: 5)
    
    static var give = OLDPlayer(name: "Peter", icon: IconSelection.dumbbell, color: .brown, hand: Card.testHandArray1, pointsToGive: 9)
    
    
    static var results = OLDPlayer(name: "Jeremy", icon: .gradCap, color: .blue, hand: Card.testHandArrayResults, score: 130, guesses: [true, false, true, true], giveTo: [4, 39, 121, 69], takeFrom: [4, 3, 23, 34])
}


enum ColorSelection: String, RawRepresentable, CaseIterable, Codable {
    case red = "red"
    case pink = "pink"
    case orange = "orange"
    case yellow = "yellow"
    case green = "green"
    case mint = "mint"
    case teal = "teal"
    case cyan = "cyan"
    case blue = "blue"
    case purple = "purple"
    case indigo = "indigo"
    case brown = "brown"
    case gray = "gray"
    case black = "black"
    
    var value: Color {
        switch self {
        case .red:
                .red
        case .pink:
                .pink
        case .orange:
                .orange
        case .yellow:
                .yellow
        case .green:
                .green
        case .mint:
                .mint
        case .teal:
                .teal
        case .cyan:
                .cyan
        case .blue:
                .blue
        case .purple:
                .purple
        case .indigo:
                .indigo
        case .brown:
                .brown
        case .gray:
                .gray
        case .black:
                .black
        }
    }
    
    static func matching(_ color: Color) -> ColorSelection {
        var colorSelection: ColorSelection?
        for selection in ColorSelection.allCases {
            if selection.value == color {
                colorSelection = selection
            }
        }
        return colorSelection ?? ColorSelection.red
    }
}
