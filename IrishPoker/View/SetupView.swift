//
//  SetUpView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/20/23.
//

import SwiftUI


struct SetupView: View {
    @EnvironmentObject var settings: SetupViewModel
    var startGameAction: () -> Void
    
    
    @AppStorage("user") private var userData: Data = Data()
    var body: some View {  
        VStack {
            NavigationLink {
                ModifyPlayer(player: $settings.player, players: $settings.players) { name, icon, colorSelection in
                    let user = User(name: name, icon: icon, color: colorSelection)
                    guard let userData = try? JSONEncoder().encode(user) else {
                        return
                    }
                    self.userData = userData
                }
                .navigationBarBackButtonHidden()
            } label: {
                PlayerHeader(player: $settings.player)
            }

            Spacer()
            Text("Irish Poker")
                .font(.system(size: 100))
                .fontWeight(.heavy)
            Spacer()
            NavigationLink {
                WaitingRoomView(host: $settings.player) {
                    startGameAction()
                }
                .navigationBarBackButtonHidden()
            } label: {
                Text("Host")
            }
            .buttonStyle(.primary)
            .background(settings.player.color)
            .cornerRadius(10)
            .padding()

//                    Button("Join", action: {})
//                        .foregroundColor(settings.player.color)
//                        .padding()
        }
        .onAppear {
            guard let user = try? JSONDecoder().decode(User.self, from: userData) else { return }
            settings.player = Player(name: user.name, icon: user.icon, color: user.color.value)
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
    return NavigationStack {
        SetupView() {}
    }
    .environmentObject(SetupViewModel())
}









//
//
//Button("Host", action: {
//    settings.players = [settings.player]
//    selection = .host
//})
