//
//  Player.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import Foundation
import SwiftUI


struct Player {
    let id = UUID()
    var name: String
    var icon: IconSelection
    var color: Color
    var hand: [Card]
    
    
    var stage: PlayerStage = .wait
    var pointsToGive: Int = 0
    var pointsToTake: Int = 0
    
    
    init(name: String, icon: IconSelection, color: Color, hand: [Card] = [], stage: PlayerStage = .wait, pointsToGive: Int = 0, pointsToTake: Int = 0) {
        self.name = name
        self.icon = icon
        self.color = color
        self.hand = hand
        self.stage = stage
        self.pointsToGive = pointsToGive
        self.pointsToTake = pointsToTake
    }
    
    init() {
        self.init(name: "", icon: .clipboard, color: .red, hand: [])
    }
    
    func copyAndRemovePointsToTake() -> Player {
        var player = self
        player.pointsToTake = 0
        return player
    }
}


extension Player: Hashable, Equatable {
    
    static func == (lhs: Player, rhs: Player) -> Bool {
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


enum PlayerStage {
    case guess
    case give
    case take
    case wait
    case end
}


extension Player {
    static var test1 = Player(name: "Jeremy", icon: .gradCap, color: .blue, hand: Card.testHandArray1)
    static var test2 = Player(name: "Sam", icon: .personFrame, color: .green, hand: Card.testHandArray2)
    static var test3 = Player(name: "Balto", icon: .idCard, color: .red, hand: Card.testHandArray3)
    static var test4 = Player(name: "Trevor", icon: .skateboard, color: .black, hand: Card.testHandArray4)
    
    static var testArr = [test1, test2, test3, test4]
    
    static var take = Player(name: "Peter", icon: IconSelection.dumbbell, color: .brown, hand: Card.testHandArray1, pointsToTake: 5)
    
    static var give = Player(name: "Peter", icon: IconSelection.dumbbell, color: .brown, hand: Card.testHandArray1, pointsToGive: 9)
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
