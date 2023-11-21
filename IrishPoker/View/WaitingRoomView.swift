//
//  WaitingRoomView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/20/23.
//

import SwiftUI

struct WaitingRoomView: View {
    @EnvironmentObject var settings: SetupViewModel
    @Binding var host: Player
    var startGameAction: () -> Void
    
    @State var newPlayer = Player()
    var takenColors: [Color] { settings.players.map({$0.color}) }
    var takenIcons: [IconSelection] { settings.players.map({$0.icon}) }
    
    @State var modifyPlayerIsPresenting = false
    
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                VStack(spacing: 0) {
                    Text("Hosting")
                        .font(.title2)
                        .fontWeight(.bold)
                    PlayerHeader(player: .constant(host))
                    if settings.gameViewSelection != .local {
                        Text("783-128-222")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.bottom)
                    }
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .background(host.color)
                
                if settings.players.count < 4 && settings.gameViewSelection == .local {
                    Button(action: { modifyPlayerIsPresenting = true }, label: {
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
                ForEach(settings.players.indices, id: \.self) { i in
                    PlayerOverview(player: .constant(settings.players[i]), showHand: false, highlightPlayer: false)
                        .padding(.horizontal)
                        .disabled(true)
                        .onTapGesture {
                            if i != 0 {
                                newPlayer = settings.players[i]
                                modifyPlayerIsPresenting = true
                                settings.players.remove(at: i)
                            }
                        }
                }
            }
            .scrollIndicators(.hidden)
            
            if settings.player == host && settings.players.count > 1 {
                Button("Start") {
                    startGameAction()
                }
                    .buttonStyle(.start)
            }
        }
        .fullScreenCover(isPresented: $modifyPlayerIsPresenting) {
            ZStack {
                ModifyPlayer(player: $newPlayer, players: $settings.players) { name, icon, color in
                    let modifiedPlayer = Player(name: name, icon: icon, color: color.value)
                    if !settings.players.contains(modifiedPlayer) {
                        settings.players.append(modifiedPlayer)
                        resetNewPlayer()
                        modifyPlayerIsPresenting = false
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
}
#Preview {
    @State var player = Player.test1
    @State var players = [Player.test1, Player.test2]
    return WaitingRoomView(host: $player, startGameAction: { }, modifyPlayerIsPresenting: true)
        .environmentObject(SetupViewModel())
}

#Preview {
    @State var players: [Player] = [Player.test1, Player.test2]
    return WaitingRoomView(host: $players[0]) { }
        .environmentObject(SetupViewModel())
}
#Preview {
    @State var players: [Player] = Player.testArr
    return WaitingRoomView(host: $players[0]) { }
        .environmentObject(SetupViewModel())
}

