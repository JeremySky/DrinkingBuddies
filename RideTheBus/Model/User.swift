//
//  User.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/11/23.
//

import Foundation


//for user defaults
struct User: Codable, Hashable {
    var id = UUID()
    var name: String = ""
    var icon: IconSelection = .drink
    var color: ColorSelection = .red
    var index: Int = 0
}



extension User {
    static var test1 = User(name: "Jeremy", icon: .skateboard, color: .blue, index: 0)
    static var test2 = User(name: "Sam", icon: .backpack, color: .green, index: 1)
    static var test3 = User(name: "Balto", icon: .book, color: .red, index: 2)
    static var test4 = User(name: "Trevor", icon: .drink, color: .black, index: 3)
    
    static var testArr = [test1, test2, test3, test4]
    
    
    
    func isValid() -> Bool {
        self.name != ""
    }
}
