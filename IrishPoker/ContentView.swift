//
//  ContentView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            CardFront(card: PlayingCard(value: .seven, suit: .hearts), degree: .constant(0))
        }
    }
}

#Preview {
    ContentView()
}
