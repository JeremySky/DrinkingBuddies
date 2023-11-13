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
    
    @State var cardSelection: CardSelection? = .four
    @State var choiceSelection: ChoiceSelection?
    
    
    //MARK: -- passed through Card object to make tappable
    @State var card1 = false
    @State var card2 = false
    @State var card3 = false
    @State var card4 = false
    
    @State var disableButtons = false
    
    
    //MARK: -- tappable helper function
    func makeTappable(_ card: inout Bool) {
        card = true
    }
    
    func makeCardSelectionTappable() {
        guard let _ = choiceSelection else { return }
        switch cardSelection {
        case .one:
            makeTappable(&card1)
        case .two:
            makeTappable(&card2)
        case .three:
            makeTappable(&card3)
        case .four:
            makeTappable(&card4)
        case nil:
            return
        }
    }
    
    
    //MARK: -- BODY
    var body: some View {
        VStack(spacing: 0) {
                Text("Guess the color")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            
            //MARK: -- ALL CARDS
            ZStack {
                Card(value: PlayingCard(value: .ten, suit: .hearts), tappable: $card1) {
                    disableButtons = true
                }
                    .scaleEffect(CGSize(width: cardSelection == .one ? 0.9 : scaleSize, height: cardSelection == .one ? 0.9 : scaleSize))
                    .offset(x: cardSelection == .one ? 0 : -90, y: cardSelection == .one ? 0 : 420)
                Card(value: PlayingCard(value: .ten, suit: .hearts), tappable: $card2) {
                    disableButtons = true
                }
                    .scaleEffect(CGSize(width: cardSelection == .two ? 0.9 : scaleSize, height: cardSelection == .two ? 0.9 : scaleSize))
                    .offset(x: cardSelection == .two ? 0 : -30, y: cardSelection == .two ? 0 : 420)
                Card(value: PlayingCard(value: .ten, suit: .hearts), tappable: $card3) {
                    disableButtons = true
                }
                    .scaleEffect(CGSize(width: cardSelection == .three ? 0.9 : scaleSize, height: cardSelection == .three ? 0.9 : scaleSize))
                    .offset(x: cardSelection == .three ? 0 : 30, y: cardSelection == .three ? 0 : 420)
                Card(value: PlayingCard(value: .ten, suit: .hearts), tappable: $card4) {
                    disableButtons = true
                }
                    .scaleEffect(CGSize(width: cardSelection == .four ? 0.9 : scaleSize, height: cardSelection == .four ? 0.9 : scaleSize))
                    .offset(x: cardSelection == .four ? 0 : 90, y: cardSelection == .four ? 0 : 420)
            }
            
            
            //MARK: -- BUTTONS
            HStack {
                Button(action: {
                    choiceSelection = choiceSelection == .one ? nil : .one
                    makeCardSelectionTappable()
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.red)
                        .frame(width: 80, height: 80)
                        .shadow(
                            color: choiceSelection == .one ? .yellow : .gray,
                            radius: 10)
                }
                .padding(.horizontal, 5)
                .disabled(disableButtons)
                
                Button(action: {
                    choiceSelection = choiceSelection == .two ? nil : .two
                    makeCardSelectionTappable()
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.black)
                        .frame(width: 80, height: 80)
                        .shadow(
                            color: choiceSelection == .two ? .yellow : .gray,
                            radius: 10)
                }
                .padding(.horizontal, 5)
                .disabled(disableButtons)
                
                Button(action: {
                    choiceSelection = choiceSelection == .three ? nil : .three
                    makeCardSelectionTappable()
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.red)
                        .frame(width: 80, height: 80)
                        .shadow(
                            color: choiceSelection == .three ? .yellow : .gray,
                            radius: 10)
                }
                .padding(.horizontal, 5)
                .disabled(disableButtons)
                
                Button(action: {
                    choiceSelection = choiceSelection == .four ? nil : .four
                    makeCardSelectionTappable()
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.black)
                        .frame(width: 80, height: 80)
                        .shadow(
                            color: choiceSelection == .four ? .yellow : .gray,
                            radius: 10)
                }
                .padding(.horizontal, 5)
                .disabled(disableButtons)
            }
            Spacer()
        }
    }
    
    enum CardSelection {
        case one, two, three, four
    }
    enum ChoiceSelection {
        case one, two, three, four
    }
}

#Preview {
    ContentView()
}

