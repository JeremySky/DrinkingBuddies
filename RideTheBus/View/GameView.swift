//
//  GameView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/14/23.
//

import SwiftUI

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
    static var preview = GameViewModel(players: Player.testArr, deck: Deck.newDeck(), gameRoomID: "ABCDE", player: Player.test1)
}

extension String {
    static func randomRoomID() -> String {
      let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789"
      return String((0..<5).map{ _ in letters.randomElement()! })
    }
}
