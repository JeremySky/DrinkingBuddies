//
//  Player.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import Foundation
import SwiftUI

struct Player: Hashable {
    let name: String
    let icon: CharacterIcon
    let color: Color
    var points: Int = 0
}

extension Player {
    static var test1 = Player(name: "Jeremy", icon: .gradCap, color: .blue)
    static var test2 = Player(name: "Sam", icon: .personFrame, color: .green)
    static var test3 = Player(name: "Balto", icon: .idCard, color: .red)
    static var test4 = Player(name: "Trevor", icon: .skateboard, color: .black)
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