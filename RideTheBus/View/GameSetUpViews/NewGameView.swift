//
//  JoinGameView.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/16/23.
//

import SwiftUI

struct NewGameView: View {
    @EnvironmentObject var game: GameManager
    @Binding var joinedGame: Bool
    var gameIsValid: Bool {
        game.lobby.players.count > 1
    }
    
    var body: some View {
        ZStack {
            VStack {
                GameHeader(user: game.host) {
                    HStack {
                        CustomBackButton() {
                            game.leaveGame()
                            joinedGame = false
                            game.resetManagerAndRepo()
                        }
                        Spacer()
                    }
                } main: {
                    HostingHeader(user: game.host, gameID: game.id)
                }
                
                ForEach(game.lobby.players, id: \.self) { player in
                    PlayerBar(player: player)
                    .padding()
                }
                Spacer()
                if game.user == game.host {
                    Button(action: {
                        Task {
                            game.startGame()
                        }
                    }, label: {
                        Text("Start")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .background(gameIsValid ? game.host.color.value : .gray.opacity(0.4))
                            .cornerRadius(10)
                            .padding(.horizontal)
                    })
                    .disabled(!gameIsValid)
                    .padding()
                }
            }
        }
    }
}

#Preview {
    @State var joinedGame = true
    return NewGameView(joinedGame: $joinedGame)
        .environmentObject(GameManager.previewSetUp)
}
