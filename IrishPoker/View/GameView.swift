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
    
    init(players: [Player]) {
        let shuffledPlayers = players.shuffled()
        self.game = Game(players: shuffledPlayers, queue: PlayerQueue(players: shuffledPlayers))
        self.currentPlayer = shuffledPlayers[0]
    }
    
    subscript<T>(dynamicMember keyPath: WritableKeyPath<Game, T>) -> T {
        get { game[keyPath: keyPath] }
        set { game[keyPath: keyPath] = newValue }
    }
    
    func fetchPlayer(using name: String) -> Player? {
        for player in game.players {
            if player.name == name {
                return player
            }
        }
        return nil
    }
    
    func updateCurrentPlayer() async {
        let updatedCurrentPlayer = await fetchPlayer(using: game.queue.peekCurrent())
        guard let updatedCurrentPlayer else { return }
        currentPlayer = updatedCurrentPlayer
    }
    
    func nextPlayersTurn() {
        Task {
            await game.shiftPlayers()
            await updateCurrentPlayer()
        }
    }
}


//MARK: -- VIEW
struct GameView: View {
    @StateObject var vm: GameViewModel
    
    var body: some View {
        TabView {
            ForEach($vm.game.players.indices, id: \.self) { i in
                PlayerView(player: $vm.players[i], players: $vm.game.players, currentPlayer: $vm.currentPlayer, nextPlayerTurn: {
                    vm.nextPlayersTurn()
                })
                    .tabItem {
                        Label(vm.players[i].name, systemImage: vm.players[i].icon.rawValue)
                    }
            }
        }
    }
}


#Preview {
    GameView(vm: GameViewModel(players: [Player.test1, Player.test2, Player.test3, Player.test4]))
}
