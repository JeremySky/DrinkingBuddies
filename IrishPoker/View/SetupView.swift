//
//  SetUpView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/20/23.
//

import SwiftUI

struct User: Codable {
    let name: String
    let icon: IconSelection
    let color: ColorSelection
}

struct SetupView: View {
    @State var selection: SetUp
    @State var player: Player = Player()
    @Binding var gameViewSelection: GameViewSelection
    var startGameAction: ([Player]) -> Void
    
    @AppStorage("user")
    private var userData: Data = Data()
    
    var body: some View {
        ZStack {
            switch selection {
            case .welcome:
                ZStack {
                    WelcomeCard {
                        delay(1.3) {
                            guard let user = try? JSONDecoder().decode(User.self, from: userData) else {
                                selection = .player
                                return
                            }
                            player = Player(name: user.name, icon: user.icon, color: user.color.value, hand: [])
                            selection = .main
                        }
                    }
                }
            case .main:
                VStack {
                    PlayerHeader(player: $player)
                        .onTapGesture {
                            selection = .player
                        }
                    Text("Bob's Your Uncle")
                        .font(.system(size: 100))
                        .fontWeight(.heavy)
                    Spacer()
                    Button("Host", action: {
                        selection = .host
                    })
                    .buttonStyle(.primary)
                    .background(player.color)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    Button("Join", action: {})
                        .foregroundColor(player.color)
                        .padding()
                }
            case .player:
                CreatePlayerForm(player: $player, players: .constant([])) { name, icon, colorSelection in
                    let user = User(name: name, icon: icon, color: colorSelection)
                    guard let userData = try? JSONEncoder().encode(user) else {
                        return
                    }
                    self.userData = userData
                    selection = .main
                }
            case .host:
                WaitingRoomView(host: $player, player: $player, players: [player], gameViewSelection: $gameViewSelection) { players in
                    startGameAction(players)
                }
            }
        }
        .onAppear {
            guard let user = try? JSONDecoder().decode(User.self, from: userData) else {
                selection = .player
                return
            }
            player = Player(name: user.name, icon: user.icon, color: user.color.value, hand: [])
            selection = .main
        }
    }
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    enum SetUp {
        case welcome
        case main
        case player
        case host
    }
}

#Preview {
    @State var gameViewSelection: GameViewSelection = .local
    return SetupView(selection: .welcome, gameViewSelection: $gameViewSelection) { _ in }
}
