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
    @ObservedObject var settings: SetupViewModel
    
    var body: some View {
        ZStack {
            switch settings.mainSelection {
            case .setup:
                SetupView()
                    .environmentObject(settings)
            case .game:
                GameView()
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
