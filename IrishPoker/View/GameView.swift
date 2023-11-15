//
//  GameView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/14/23.
//

import SwiftUI

struct GameView: View {
    let players = [Player.test1, Player.test2, Player.test3, Player.test4]
    var playerQueue: PlayerQueue = PlayerQueue(players: [Player.test1, Player.test2, Player.test3, Player.test4])
    @State var question: Question = .one
    @State var gamePhase: GamePhase = .guessing
    @State var currentPlayer: Player? = nil
    @State var nextPlayer: Player? = nil
    
    
    var body: some View {
        TabView {
            ForEach(players, id: \.self) { player in
                PlayerView(player: player, question: $question, gamePhase: $gamePhase, currentPlayer: $currentPlayer, nextPlayer: $nextPlayer) {
                    Task {
                        await playerQueue.rotateQueue()
                    }
                }
                    .tabItem {
                        Label(player.name, systemImage: player.icon.rawValue)
                    }
                    .task {
                        await currentPlayer = playerQueue.peekCurrent()
                        await nextPlayer = playerQueue.peekNext()
                    }
            }
        }
    }
}

#Preview {
    GameView()
}


actor PlayerQueue: ObservableObject {
    private var queue: [Player]
    
    init(players: [Player]) {
        self.queue = players.shuffled()
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
