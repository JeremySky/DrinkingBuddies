//
//  PlayerView.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/13/23.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var game: GameManager
    
    var body: some View {
        switch game.lobby.players[game.user.index].stage {
        case .guessing:
            Text("Guess")
        case .giving:
            Text("Give")
        case .taking:
            Text("Take")
        case .waiting:
            Text("Wait")
        case .results:
            Text("End")
        }
    }
}

#Preview {
    GameView()
        .environmentObject(GameManager.previewGameStarted)
}
