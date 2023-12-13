//
//  User.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/11/23.
//

import Foundation


//for user defaults
struct User: Codable {
    var id = UUID()
    var name: String = ""
    var icon: IconSelection = .drink
    var color: ColorSelection = .red
}

extension User {
    static var test1 = User(name: "Jeremy", icon: .skateboard, color: .blue)
    static var test2 = User(name: "Sam", icon: .backpack, color: .green)
    static var test3 = User(name: "Balto", icon: .book, color: .red)
    static var test4 = User(name: "Trevor", icon: .drink, color: .black)
    
    static var testArr = [test1, test2, test3]
}
