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
    
    init(players: [Player]) {
        let shuffledPlayers = players.shuffled()
        self.game = Game(players: shuffledPlayers, queue: PlayerQueue(players: shuffledPlayers), currentPlayer: shuffledPlayers[0])
    }
    
    subscript<T>(dynamicMember keyPath: WritableKeyPath<Game, T>) -> T {
        get { game[keyPath: keyPath] }
        set { game[keyPath: keyPath] = newValue }
    }
    
    
    func endPlayersTurn() {
        Task {
            await game.nextPlayer()
            await game.currentPlayer = game.getPlayer(using: await game.queue.peek())
        }
    }
}


//MARK: -- VIEW
struct GameView: View {
    @StateObject var game: GameViewModel
    
    var body: some View {
        TabView {
            ForEach($game.players.indices, id: \.self) { i in
                PlayerView(player: $game.players[i])
                    .environmentObject(game)
                    .tabItem {
                        Label(game.players[i].name, systemImage: game.players[i].icon.rawValue)
                    }
            }
        }
    }
}


#Preview {
    GameView(game: GameViewModel.preview)
}





extension GameViewModel {
    static var preview = GameViewModel(players: Player.testArr)
}
