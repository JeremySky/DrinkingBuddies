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
            switch game.stage {
            case .guessing:
                PlayerTurnView()
            case .giving:
                GiveView(pointsToGiveReference: game.fetchUsersPlayerReference().pointsToGive, lobbyReference: game.lobby)
            case .taking:
                TakeView(pointsToTakeReference: game.fetchUsersPlayerReference().pointsToTake, countdown: game.fetchUsersPlayerReference().pointsToTake)
            case .waiting:
                WaitView()
            case .results:
                ResultsView()
            }
        }
        .onAppear {
            game.updateUserIndex()
            print(game.user.index)
        }
    }
}

#Preview {
    GameView()
        .environmentObject(GameManager.previewGameStarted)
}
