//
//  MainView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/20/23.
//

import SwiftUI



struct MainView: View {
    @StateObject var game: GameManager
    
    var body: some View {
        ZStack {
            if !game.hasStarted {
                GameSetupView()
                    .environmentObject(game)
            } else {
                //PLAYER VIEW
                GameView()
                    .environmentObject(game)
                    .onAppear {
                        game.updateUserIndex()
                    }
            }
        }
    }
}

#Preview {
    @State var user: User = User.test1
    return MainView(user: user)
}

extension MainView {
    init(user: User) {
        self._game = StateObject(wrappedValue: GameManager(user: user))
    }
}




enum AppViewSelection {
    case setup
    case game
}
