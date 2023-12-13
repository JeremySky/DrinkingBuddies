//
//  GameView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/14/23.
//

import SwiftUI

//MARK: -- VIEW
struct GameView: View {
    @EnvironmentObject var game: GameManager
    
    var body: some View {
        ZStack {
            if !game.hasStarted {
                
            } else {
                
            }
        }
    }
}

#Preview {
    GameView()
        .environmentObject(GameManager.previewOnePlayer)
}


extension GameManager {
    static var previewOnePlayer = GameManager(user: User.test1)
}


extension OLDGameViewModel {
    static var preview = OLDGameViewModel(game: OLDGame(deck: Deck.newDeck(), players: OLDPlayer.testArr, phase: .guessing, question: .one, currentPlayer: OLDPlayer.test1, waitingRoom: OLDPlayer.testArr),gameRoomID: "ABCDE", player: OLDPlayer.test1)
}
