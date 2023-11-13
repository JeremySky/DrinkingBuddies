//
//  ContentView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/11/23.
//

import SwiftUI

struct ContentView: View {
    @State var deck = Deck()
    @State var scaleSize: CGFloat = 0.25
    
    @State var highlightCard1 = true
    @State var highlightCard2 = false
    @State var highlightCard3 = false
    @State var highlightCard4 = false
    
    @State var selection: Selection?
    
    var body: some View {
        VStack(spacing: 0) {
                Text("Guess the color")
                .font(.largeTitle)
                .fontWeight(.bold)
            ZStack {
                Card(value: PlayingCard(value: .ten, suit: .hearts))
                    .scaleEffect(CGSize(width: highlightCard1 ? 0.9 : scaleSize, height: highlightCard1 ? 0.9 : scaleSize))
                    .offset(x: highlightCard1 ? 0 : -90, y: highlightCard1 ? 0 : 420)
                Card(value: PlayingCard(value: .ten, suit: .hearts))
                    .scaleEffect(CGSize(width: highlightCard2 ? 0.9 : scaleSize, height: highlightCard2 ? 0.9 : scaleSize))
                    .offset(x: highlightCard2 ? 0 : -30, y: highlightCard2 ? 0 : 420)
                Card(value: PlayingCard(value: .ten, suit: .hearts))
                    .scaleEffect(CGSize(width: highlightCard3 ? 0.9 : scaleSize, height: highlightCard3 ? 0.9 : scaleSize))
                    .offset(x: highlightCard3 ? 0 : 30, y: highlightCard3 ? 0 : 420)
                Card(value: PlayingCard(value: .ten, suit: .hearts))
                    .scaleEffect(CGSize(width: highlightCard4 ? 0.9 : scaleSize, height: highlightCard4 ? 0.9 : scaleSize))
                    .offset(x: highlightCard4 ? 0 : 90, y: highlightCard4 ? 0 : 420)
            }
            HStack {
                Button(action: {
                    selection = selection == .one ? nil : .one
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.red)
                        .frame(width: 80, height: 80)
                        .shadow(
                            color: selection == .one ? .yellow : .gray,
                            radius: 10)
                }
                .padding(.horizontal, 5)
                Button(action: {
                    selection = selection == .two ? nil : .two
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.black)
                        .frame(width: 80, height: 80)
                        .shadow(
                            color: selection == .two ? .yellow : .gray,
                            radius: 10)
                }
                .padding(.horizontal, 5)
                Button(action: {
                    selection = selection == .three ? nil : .three
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.red)
                        .frame(width: 80, height: 80)
                        .shadow(
                            color: selection == .three ? .yellow : .gray,
                            radius: 10)
                }
                .padding(.horizontal, 5)
                Button(action: {
                    selection = selection == .four ? nil : .four
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.black)
                        .frame(width: 80, height: 80)
                        .shadow(
                            color: selection == .four ? .yellow : .gray,
                            radius: 10)
                }
                .padding(.horizontal, 5)
            }
            Spacer()
        }
    }
    
    enum Selection {
        case one, two, three, four
    }
}

#Preview {
    ContentView()
}

