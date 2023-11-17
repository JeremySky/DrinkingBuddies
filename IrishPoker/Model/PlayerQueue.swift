//
//  PlayerQueue.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/15/23.
//

import Foundation

actor PlayerQueue: ObservableObject {
    private var players: [String]
    private var queue: [String]
    
    init(players: [Player]) {
        let players = players.map( {$0.name} )
        self.players = players
        self.queue = players
    }
    
    func peek() -> String {
        queue[0]
    }
    func dequeue() {
        queue.removeFirst()
    }
    func reset() {
        queue = players
    }
}
