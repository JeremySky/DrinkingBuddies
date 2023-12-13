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
    
    init(players: [OLDPlayer]) {
        let players = players.map( {$0.name} )
        self.players = players
        self.queue = players
    }
    
    func rotate() {
        enqueue(player: peek())
        dequeue()
    }
    func peek() -> String {
        queue[0]
    }
    private func dequeue() {
        queue.removeFirst()
    }
    private func enqueue(player: String) {
        queue.append(player)
    }
}
