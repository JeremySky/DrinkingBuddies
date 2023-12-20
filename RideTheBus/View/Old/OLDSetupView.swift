//
//  SetUpView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/20/23.
//

import SwiftUI


struct OLDSetupView: View {
    @EnvironmentObject var game: OLDGameViewModel
    
    
    var playerIcons: [IconSelection]  = IconSelection.allCases
    var colors: [ColorSelection] = ColorSelection.allCases
    @State var iconIndex = 0
    @State var colorIndex = 4
    
    @State var roomID = ""
    
    @AppStorage("user") private var userData: Data = Data()
    var body: some View {
        switch game.setupSelection {
        case .main:
            VStack {
                Button(action: { game.setupSelection = .player }, label: {
                    if game.player != OLDPlayer() {
                        PlayerHeader(player: $game.player)
                    } else {
                        UserIcon(icon: playerIcons[iconIndex], color: colors[colorIndex], selected: false)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .padding(.bottom, 4)
                            .background(colors[colorIndex].value)
                    }
                })
                
                Spacer()
                Text("Ride \nThe \nBus")
                    .font(.system(size: 100))
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                Spacer()
                
                if game.player != OLDPlayer() {
                    Button {
                        game.createNewGame()
                        game.setupSelection = .host
                    } label: {
                        Text("Host")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(game.player.color)
                    }
                    .cornerRadius(10)
                    .padding()
                    
                    HStack {
                        TextField("Room ID", text: $roomID)
                            .padding()
                            .background(.gray.opacity(0.4))
                            .padding()
                        Button("Join") {
                            game.joinGame(id: roomID)
                            game.setupSelection = .host
                        }
                    }
                } else {
                    Button {
                        game.setupSelection = .player
                    } label: {
                        Text("Player Setup")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(colors[colorIndex].value)
                    }
                    .cornerRadius(10)
                    .padding()
                }
            }
            .onAppear {
                if game.player == OLDPlayer() {
//                    startTimers()
                }
                guard let user = try? JSONDecoder().decode(User.self, from: userData) else { return }
                game.player = OLDPlayer(name: user.name, icon: user.icon, color: user.color.value)
            }
        case .player:
            OLDModifyPlayer(player: $game.player, players: $game.players) { name, icon, colorSelection in
                let user = User(name: name, icon: icon, color: colorSelection)
                guard let userData = try? JSONEncoder().encode(user) else {
                    return
                }
                self.userData = userData
                game.setupSelection = .main
            }
        case .host:
            SetupWaitingRoom()
        }
    }
    
}

enum SetupSelection {
    case main
    case player
    case host
}
//
//#Preview {
//    @State var gameViewSelection: GameViewSelection = .local
//    @State var players: [OLDPlayer] = []
//    return NavigationStack {
//        SetupView()
//    }
//    .environmentObject(OLDGameViewModel())
//}









//
//
//Button("Host", action: {
//    game.players = [game.player]
//    selection = .host
//})
