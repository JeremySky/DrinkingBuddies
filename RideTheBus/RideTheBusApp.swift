//
//  IrishPokerApp.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/11/23.
//

import SwiftUI

@main
struct RideTheBusApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(settings: SetupViewModel())
        }
    }
}

