//
//  WaitingRoomView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/20/23.
//

import SwiftUI

struct WaitingRoomView: View {
    @Binding var host: Player
    @Binding var player: Player
    @State var players: [Player]
    @Binding var gameViewSelection: GameViewSelection
    var startGameAction: ([Player]) -> Void
    
    @State var newPlayer = Player()
    var takenColors: [Color] { players.map({$0.color}) }
    var takenIcons: [IconSelection] { players.map({$0.icon}) }
    
    @State var isPresenting = false
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                VStack(spacing: 0) {
                    Text("Hosting")
                        .font(.title2)
                        .fontWeight(.bold)
                    PlayerHeader(player: .constant(host))
                    if gameViewSelection != .local {
                        Text("783-128-222")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.bottom)
                    }
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .background(host.color)
                
                if players.count < 4 && gameViewSelection == .local {
                    Button(action: { isPresenting = true }, label: {
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                            Image(systemName: "person.badge.plus")
                                .resizable()
                                .scaledToFit()
                                .padding(.all, 6)
                                .foregroundStyle(host.color)
                        }
                        .frame(width: 50, height: 50)
                        .padding(.trailing)
                    })
                }
            }
            ScrollView {
                Spacer()
                    .frame(height: 20)
                ForEach(players.indices, id: \.self) { i in
                    PlayerOverview(player: .constant(players[i]), showHand: false, highlightPlayer: false)
                        .padding(.horizontal)
                        .disabled(true)
                        .onTapGesture {
                            if i != 0 {
                                newPlayer = players[i]
                                isPresenting = true
                                players.remove(at: i)
                            }
                        }
                }
            }
            .scrollIndicators(.hidden)
            
            if player == host && players.count > 1 {
                Button("Start") {
                    startGameAction(players)
                }
                    .buttonStyle(.start)
            }
        }
        .fullScreenCover(isPresented: $isPresenting) {
            ZStack {
                CreatePlayerForm(player: $newPlayer, players: $players) { name, icon, color in
                    let modifiedPlayer = Player(name: name, icon: icon, color: color.value)
                    if !players.contains(modifiedPlayer) {
                        players.append(modifiedPlayer)
                        resetNewPlayer()
                        isPresenting = false
                    } else {
                        
                    }
                }
            }
        }
    }
    
    func resetNewPlayer() {
        var defaultIcon: IconSelection = .clipboard
        var defaultColor: Color = .red
        for color in Color.selection {
            if takenColors.contains(color) {
                continue
            } else {
                defaultColor = color
                break
            }
        }
        for icon in IconSelection.allCases {
            if takenIcons.contains(icon) {
                continue
            } else {
                defaultIcon = icon
                break
            }
        }
        newPlayer = Player(name: "", icon: defaultIcon, color: defaultColor)
    }
    
    enum WaitingRoomSelection {
        case main
        case addPlayer
    }
}
#Preview {
    @State var player = Player.test1
    return WaitingRoomView(host: $player, player: $player, players: [Player.test1, Player.test2], gameViewSelection: .constant(.local), startGameAction: { _ in }, isPresenting: true)
}

#Preview {
    @State var player = Player.test1
    @State var host = Player.test2
    return WaitingRoomView(host: $host, player: $player, players: [host, player], gameViewSelection: .constant(.local)) { _ in }
}
#Preview {
    @State var player = Player.test1
    @State var host = Player.test2
    return WaitingRoomView(host: $host, player: $player, players: Player.testArr, gameViewSelection: .constant(.remoteWifi)) { _ in }
}

