//
//  GameView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/14/23.
//

import SwiftUI


@MainActor
class GameViewModel: ObservableObject {
    @Published var players: [Player]
    @Published var queue: PlayerQueue
    @Published var currentPlayer: Player
    @Published var nextPlayer: Player
    
    init(players: [Player]) {
        let queue = players.shuffled()
        self.players = queue
        self.queue = PlayerQueue(queue: queue)
        self.currentPlayer = queue[0]
        self.nextPlayer = queue[1]
    }
    
    func nextPlayersTurn() {
        Task {
            await queue.rotateQueue()
            currentPlayer = await queue.peekCurrent()
            nextPlayer = await queue.peekNext()
        }
    }
}


struct GameView: View {
    @StateObject var vm: GameViewModel
    
    var body: some View {
        TabView {
            ForEach(vm.players, id: \.self) { player in
                PlayerView(player: player, currentPlayer: $vm.currentPlayer, nextPlayer: $vm.nextPlayer, nextPlayerTurn: {
                    vm.nextPlayersTurn()
                })
                    .tabItem {
                        Label(player.name, systemImage: player.icon.rawValue)
                    }
            }
        }
    }
}



actor PlayerQueue: ObservableObject {
    var queue: [Player]
    
    init(queue: [Player]) {
        self.queue = queue
    }
    
    func peekCurrent() -> Player {
        queue[0]
    }
    func peekNext() -> Player {
        queue[1]
    }
    func dequeue() {
        queue.removeFirst()
    }
    func enqueue(_ player: Player) {
        queue.append(player)
    }
    func rotateQueue() {
        enqueue(queue[0])
        dequeue()
    }
}

enum GamePhase {
    case guessing
    case giveTake
}

enum Question: String, RawRepresentable {
    case one = "Guess the Color"
    case two = "Higher or Lower"
    case three = "Inside or Outside"
    case four = "Guess the Suit"
    
    var number: Int {
        switch self {
        case .one:
            1
        case .two:
            2
        case .three:
            3
        case .four:
            4
        }
    }
}
