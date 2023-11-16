//
//  PlayerQueue.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/15/23.
//

import Foundation

actor PlayerQueue: ObservableObject {
    var queue: [String]
    
    init(players: [Player]) {
        self.queue = players.map( {$0.name} )
    }
    
    func peekCurrent() -> String {
        queue[0]
    }
    func peekNext() -> String {
        queue[1]
    }
    func dequeue() {
        queue.removeFirst()
    }
    func enqueue(_ player: String) {
        queue.append(player)
    }
    func rotateQueue() {
        enqueue(queue[0])
        dequeue()
    }
}
