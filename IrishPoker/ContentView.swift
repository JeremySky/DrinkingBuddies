//
//  ContentView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/11/23.
//

import SwiftUI

struct ContentView: View {
    @State var deck = Deck()
    
    var body: some View {
        Card(value: PlayingCard(value: .ten, suit: .hearts))
    }
}

#Preview {
    ContentView()
}
