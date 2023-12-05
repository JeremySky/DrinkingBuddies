//
//  SetUpView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/20/23.
//

import SwiftUI


struct SetupView: View {
    @EnvironmentObject var settings: SetupViewModel
    var playerIcons: [IconSelection]  = IconSelection.allCases
    var colors: [ColorSelection] = ColorSelection.allCases
    @State var iconIndex = 0
    @State var colorIndex = 4
    
    
    @AppStorage("user") private var userData: Data = Data()
    var body: some View {
        switch settings.setupSelection {
        case .main:
            VStack {
                Button(action: { settings.setupSelection = .player }, label: {
                    if settings.player != Player() {
                        PlayerHeader(player: $settings.player)
                    } else {
                        PlayerIcon(icon: playerIcons[iconIndex], color: colors[colorIndex].value, weight: .black)
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
                
                if settings.player != Player() {
                    Button {
                        settings.setupSelection = .host
                    } label: {
                        Text("Host")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(settings.player.color)
                    }
                    .cornerRadius(10)
                    .padding()
                } else {
                    Button {
                        settings.setupSelection = .player
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
                if settings.player == Player() {
                    startTimers()
                }
                guard let user = try? JSONDecoder().decode(User.self, from: userData) else { return }
                settings.player = Player(name: user.name, icon: user.icon, color: user.color.value)
            }
        case .player:
            ModifyPlayer(player: $settings.player, players: $settings.players) { name, icon, colorSelection in
                let user = User(name: name, icon: icon, color: colorSelection)
                guard let userData = try? JSONEncoder().encode(user) else {
                    return
                }
                self.userData = userData
                settings.setupSelection = .main
            }
        case .host:
            SetupWaitingRoom(host: $settings.player)
        }
    }
    
    func startTimers() {
        Timer.scheduledTimer(withTimeInterval: 3.1, repeats: true) { _ in
            withAnimation {
                iconIndex = (iconIndex + 1) % playerIcons.count
                colorIndex = (colorIndex + 1) % colors.count
            }
        }
    }
}

enum SetupSelection {
    case main
    case player
    case host
}

#Preview {
    @State var gameViewSelection: GameViewSelection = .local
    @State var players: [Player] = []
    return NavigationStack {
        SetupView()
    }
    .environmentObject(SetupViewModel())
}









//
//
//Button("Host", action: {
//    settings.players = [settings.player]
//    selection = .host
//})
