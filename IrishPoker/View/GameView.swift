//
//  GameView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/14/23.
//

import SwiftUI

//MARK: -- VIEW MODEL
@MainActor
@dynamicMemberLookup
class GameViewModel: ObservableObject {
    @Published var game: Game
    @Published var currentPlayer: Player
    @Published var waitingRoom: [Player]
    
    init(players: [Player]) {
        var shuffledPlayers = players.shuffled()
        shuffledPlayers[0].stage = .guess
        
        self.game = Game(players: shuffledPlayers)
        self.currentPlayer = shuffledPlayers[0]
        self.waitingRoom = shuffledPlayers
    }
    
    subscript<T>(dynamicMember keyPath: WritableKeyPath<Game, T>) -> T {
        get { game[keyPath: keyPath] }
        set { game[keyPath: keyPath] = newValue }
    }
    
    
    func updateQuestion() {
        if waitingRoom[0].id == game.players[0].id {
            switch game.question {
            case .one:
                game.question = .two
            case .two:
                game.question = .three
            case .three:
                game.question = .four
            case .four:
                game.phase = .giveTake
            }
        }
    }
    
    func updateCurrentPlayer() {
        waitingRoom.append(currentPlayer)
        waitingRoom.removeFirst()
        currentPlayer = waitingRoom[0]
    }
}


//MARK: -- VIEW
struct GameView: View {
    @StateObject var game: GameViewModel
    @State var selection: GameViewSelection
    
    var body: some View {
        switch selection {
        case .local:
            LocalGameView()
                .environmentObject(game)
        case .remoteBluetooth, .remoteWifi:
            PlayerView(player: .constant(Player.test1))
                .environmentObject(game)
        }
    }
}


enum GameViewSelection {
    case local
    case remoteBluetooth
    case remoteWifi
}


#Preview {
    GameView(game: GameViewModel.preview, selection: .local)
}





extension GameViewModel {
    static var preview = GameViewModel(players: Player.testArr)
}
