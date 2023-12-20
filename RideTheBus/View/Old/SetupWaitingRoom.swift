//
//  WaitingRoomView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/20/23.
//

import SwiftUI

struct SetupWaitingRoom: View {
    @EnvironmentObject var game: OLDGameViewModel
    
    @State var newPlayer = OLDPlayer()
//    var takenColors: [ColorSelection] { game.players.map({$0.color}) }
    var takenIcons: [IconSelection] { game.players.map({$0.icon}) }
    
    @State var modifyPlayerIsPresenting = false
    @State var playerIndex: Int? = nil
    
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                VStack(spacing: 0) {
                    ZStack {
                        HStack {
                            Button(action: {game.setupSelection = .main}) {
                                Image(systemName: "chevron.left")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.white)
                                    .frame(width: 25, height: 20)
                                    .fontWeight(.heavy)
                            }
                            
                            Spacer()
                            
                            if game.players.count < 4 && game.gameViewSelection == .local {
                                Button(action: { modifyPlayerIsPresenting = true }, label: {
                                    Image(systemName: "person.badge.plus")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(.white)
                                        .frame(width: 28, height: 28)
                                        .fontWeight(.bold)
                                })
                            }
                        }
                        Text("Host")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    PlayerHeader(player: .constant(game.host))
                    if game.gameViewSelection != .local {
                        Text(game.gameRoomID)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.bottom)
                    }
                    
                    Text(game.gameRoomID)
                        .font(.headline)
                        .bold()
                        .padding(.bottom)
                }
                .padding(.horizontal)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .background(game.host.color)
            }
            ScrollView {
                Spacer()
                    .frame(height: 20)
                ForEach(game.players.indices, id: \.self) { i in
                    OLDPlayerOverview(player: .constant(game.players[i]), showHand: false, highlightPlayer: false)
                        .padding(.horizontal)
                        .disabled(true)
                        .onTapGesture {
                            if i != 0 {
                                newPlayer = game.players[i]
                                modifyPlayerIsPresenting = true
                                playerIndex = i
                            }
                        }
                }
            }
            .scrollIndicators(.hidden)
            
            if game.player == game.host && game.players.count > 1 {
                Button("Start") {
                    print("Start")
//                    game.mainSelection = .game
                }
                .buttonStyle(.start)
            }
        }
        .onAppear {
            game.players = [game.host]
        }
        .sheet(isPresented: $modifyPlayerIsPresenting) {
            ZStack {
                OLDModifyPlayer(player: $newPlayer, players: $game.players, paddingTop: true) { name, icon, color in
                    let modifiedPlayer = OLDPlayer(name: name, icon: icon, color: color.value)
                    guard let playerIndex else {
                        game.players.append(modifiedPlayer)
                        modifyPlayerIsPresenting = false
                        return
                    }
                    game.players[playerIndex] = newPlayer
                    self.playerIndex = nil
                    modifyPlayerIsPresenting = false
                }
                .onDisappear(perform: {
                    resetNewPlayer()
                })
            }
        }
    }
    
    func resetNewPlayer() {
        var defaultIcon: IconSelection = .clipboard
        var defaultColor: ColorSelection = .red
//        for color in Color.selection {
//            if takenColors.contains(color) {
//                continue
//            } else {
//                defaultColor = color
//                break
//            }
//        }
        for icon in IconSelection.allCases {
            if takenIcons.contains(icon) {
                continue
            } else {
                defaultIcon = icon
                break
            }
        }
//        newUser = User(name: "", icon: defaultIcon, color: defaultColor)
    }
}
//#Preview {
//    @State var player = Player.test1
//    @State var players = [Player.test1, Player.test2]
//    return WaitingRoomView(game.host: $player, startGameAction: { }, modifyPlayerIsPresenting: true)
//        .environmentObject(SetupViewModel())
//}

#Preview {
    @State var players: [OLDPlayer] = [OLDPlayer.test1, OLDPlayer.test2]
    return NavigationStack {
        SetupWaitingRoom()
    }
    .environmentObject(OLDGameViewModel())
}
#Preview {
    @State var players: [OLDPlayer] = OLDPlayer.testArr
    return SetupWaitingRoom()
        .environmentObject(OLDGameViewModel())
}

