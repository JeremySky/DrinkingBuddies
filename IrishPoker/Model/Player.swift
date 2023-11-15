//
//  Player.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import Foundation
import SwiftUI

struct Player {
    let name: String
    let icon: CharacterIcon
    let color: Color
    var points: Int = 0
    var hand: Hand
}

extension Player {
    static var test1 = Player(name: "Jeremy", icon: .gradCap, color: .blue, hand: Hand.test)
    static var test2 = Player(name: "Sam", icon: .personFrame, color: .green, hand: Hand.test)
    static var test3 = Player(name: "Balto", icon: .idCard, color: .red, hand: Hand.test)
    static var test4 = Player(name: "Trevor", icon: .skateboard, color: .black, hand: Hand.test)
}


enum PlayerNumber {
    case one, two, three, four
}

enum CharacterIcon: String, RawRepresentable {
    case clipboard = "pencil.and.list.clipboard"
    case book = "text.book.closed"
    case gradCap = "graduationcap"
    case backpack = "backpack"
    case paperclip = "paperclip"
    case personFrame = "person.crop.artframe"
    case photoFrame = "photo.artframe"
    case idCard = "person.text.rectangle"
    case dumbbell = "dumbbell.fill"
    case skateboard = "skateboard"
}

struct Hand: Hashable {
    var one: PlayingCard
    var two: PlayingCard
    var three: PlayingCard
    var four: PlayingCard
    
    static var test: Hand = Hand(one: PlayingCard.test1, two: PlayingCard.test2, three: PlayingCard.test3, four: PlayingCard.test4)
}



extension Player: Hashable {
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return (
            lhs.name == rhs.name &&
            lhs.icon == rhs.icon &&
            lhs.color == rhs.color &&
            lhs.points == rhs.points &&
            lhs.hand == rhs.hand
        )
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(icon)
        hasher.combine(color)
        hasher.combine(points)
        hasher.combine(hand)
    }
    
}
