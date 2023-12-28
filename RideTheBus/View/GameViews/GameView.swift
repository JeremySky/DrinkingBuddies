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
        ZStack {
            switch game.phase {
            case .giveTake, .guessing:
                switch game.stage {
                case .guessing:
                    PlayerTurnView()
                case .giving:
                    GiveView(pointsToGiveReference: game.fetchUsersPlayerReference().pointsToGive, lobbyReference: game.lobby.clearPointsToTake())
                case .taking:
                    TakeView(pointsToTakeReference: game.fetchUsersPlayerReference().pointsToTake, countdown: game.fetchUsersPlayerReference().pointsToTake)
                case .waiting:
                    WaitView()
                    
                }
            case .results:
                ResultsView()
            }
        }
        .onAppear {
            game.updateUserIndex()
        }
        .onReceive(game.$game, perform: { _ in
            if !game.checkForGameEnd() {
                game.updateStage()
            }
        })
    }
}

#Preview {
    GameView()
        .environmentObject(GameManager.previewGameStarted)
}
