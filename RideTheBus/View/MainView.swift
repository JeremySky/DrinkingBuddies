//
//  MainView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/20/23.
//

import SwiftUI



@MainActor
class SetupViewModel: ObservableObject {
    @Published var gameViewSelection: GameViewSelection = .local
    @Published var mainSelection: AppViewSelection = .setup
    @Published var setupSelection: SetupSelection = .main
    
    
}

struct MainView: View {
    @ObservedObject var settings = SetupViewModel()
    @ObservedObject var game = GameViewModel()
    
    var body: some View {
        ZStack {
            switch settings.mainSelection {
            case .setup:
                SetupView()
                    .environmentObject(settings)
                    .environmentObject(game)
            case .game:
                GameView()
                    .environmentObject(game)
            }
        }
    }
}

#Preview {
    MainView(settings: SetupViewModel())
}

//for user defaults
struct User: Codable {
    let name: String
    let icon: IconSelection
    let color: ColorSelection
}


enum AppViewSelection {
    case setup
    case game
}
