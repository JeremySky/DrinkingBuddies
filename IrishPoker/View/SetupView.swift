//
//  SetUpView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/20/23.
//

import SwiftUI


struct SetupView: View {
    @EnvironmentObject var settings: SetupViewModel
    @State var selection: SetUpSelection = .player
    var startGameAction: () -> Void
    
    
    @AppStorage("user") private var userData: Data = Data()
    var body: some View {
        ZStack {
            switch selection {
            case .main:
                VStack {
                    PlayerHeader(player: $settings.player)
                        .onTapGesture {
                            selection = .player
                        }
                    Text("Bob's Your Uncle")
                        .font(.system(size: 100))
                        .fontWeight(.heavy)
                    Spacer()
                    Button("Host", action: {
                        settings.players = [settings.player]
                        selection = .host
                    })
                    .buttonStyle(.primary)
                    .background(settings.player.color)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    Button("Join", action: {})
                        .foregroundColor(settings.player.color)
                        .padding()
                }
            case .player:
                ModifyPlayer(player: $settings.player, players: $settings.players) { name, icon, colorSelection in
                    let user = User(name: name, icon: icon, color: colorSelection)
                    guard let userData = try? JSONEncoder().encode(user) else {
                        return
                    }
                    self.userData = userData
                    selection = .main
                }
            case .host:
                WaitingRoomView(host: $settings.player) {
                    startGameAction()
                }
            }
        }
        .onAppear {
            guard let user = try? JSONDecoder().decode(User.self, from: userData) else {
                selection = .player
                return
            }
            settings.player = Player(name: user.name, icon: user.icon, color: user.color.value)
            selection = .main
        }
    }
}

enum SetUpSelection {
    case main
    case player
    case host
}

#Preview {
    @State var gameViewSelection: GameViewSelection = .local
    @State var players: [Player] = []
    return SetupView() {}
        .environmentObject(SetupViewModel())
}
