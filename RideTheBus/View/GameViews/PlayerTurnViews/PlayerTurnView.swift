//
//  PlayersTurnView.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/14/23.
//

import SwiftUI

struct PlayerTurnView: View {
    @EnvironmentObject var game: GameManager
    
    var body: some View {
        ZStack {
            switch game.phase {
            case .guessing:
                GuessingView()
            case .giveTake:
                GiveTakeView()
            }
        }
    }
}

#Preview {
    PlayerTurnView()
        .environmentObject(GameManager.previewGameStarted)
}
