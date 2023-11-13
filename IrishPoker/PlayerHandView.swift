//
//  ContentView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/11/23.
//

import SwiftUI

struct PlayerHandView: View {
    var hand: [PlayingCard]
    @State var question: Question?
    
    @State var cardSelection: CardSelection?
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
            Text(question?.rawValue ?? "")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            
            //MARK: -- ALL CARDS
            ZStack {
                Card(value: hand[0], tappable: $card1) {
                    disableButtons = true
                }
                .scaleEffect(CGSize(width: cardSelection == .one ? 0.85 : 0.25, height: cardSelection == .one ? 0.85 : 0.25))
                .offset(x: cardSelection == .one ? 0 : -90, y: cardSelection == .one ? 0 : 420)
                Card(value: hand[1], tappable: $card2) {
                    disableButtons = true
                }
                .scaleEffect(CGSize(width: cardSelection == .two ? 0.85 : 0.25, height: cardSelection == .two ? 0.85 : 0.25))
                .offset(x: cardSelection == .two ? 0 : -30, y: cardSelection == .two ? 0 : 420)
                Card(value: hand[2], tappable: $card3) {
                    disableButtons = true
                }
                .scaleEffect(CGSize(width: cardSelection == .three ? 0.85 : 0.25, height: cardSelection == .three ? 0.85 : 0.25))
                .offset(x: cardSelection == .three ? 0 : 30, y: cardSelection == .three ? 0 : 420)
                Card(value: hand[3], tappable: $card4) {
                    disableButtons = true
                }
                .scaleEffect(CGSize(width: cardSelection == .four ? 0.85 : 0.25, height: cardSelection == .four ? 0.85 : 0.25))
                .offset(x: cardSelection == .four ? 0 : 90, y: cardSelection == .four ? 0 : 420)
            }.zIndex(1)
            
            
            //MARK: -- BUTTONS
            HStack {
                switch question {
                case .one:
                    Button(action: {
                        choiceSelection = choiceSelection == .one ? nil : .one
                        makeCardSelectionTappable()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color.red)
                                .frame(width: 80, height: 80)
                                .shadow(
                                    color: choiceSelection == .one ? .yellow : .gray,
                                    radius: 10)
                            Text("Red")
                                .foregroundStyle(Color.white)
                                .font(.system(size: 27))
                                .fontWeight(.bold)
                        }
                    }
                    .padding(.horizontal, 5)
                    .disabled(disableButtons)
                    
                    
                    Button(action: {
                        choiceSelection = choiceSelection == .two ? nil : .two
                        makeCardSelectionTappable()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color.black)
                                .frame(width: 80, height: 80)
                                .shadow(
                                    color: choiceSelection == .two ? .yellow : .gray,
                                    radius: 10)
                            Text("Black")
                                .foregroundStyle(Color.white)
                                .font(.system(size: 27))
                                .fontWeight(.bold)
                        }
                    }
                    .padding(.horizontal, 5)
                    .disabled(disableButtons)
                case .two:
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
                    
                case .three:
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
                    
                case .four:
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
                case nil:
                    EmptyView()
                }
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
    enum Question: String, RawRepresentable {
        case one = "Guess the Color"
        case two = "Higher or Lower"
        case three = "Inside or Outside"
        case four = "Guess the Suit"
    }
}

#Preview {
    PlayerHandView(hand: [
        PlayingCard(value: .ace, suit: .hearts),
        PlayingCard(value: .eight, suit: .clubs),
        PlayingCard(value: .king, suit: .diamonds),
        PlayingCard(value: .ten, suit: .spades)
    ], question: .one ,cardSelection: .one)
}
#Preview {
    PlayerHandView(hand: [
        PlayingCard(value: .ace, suit: .hearts),
        PlayingCard(value: .eight, suit: .clubs),
        PlayingCard(value: .king, suit: .diamonds),
        PlayingCard(value: .ten, suit: .spades)
    ], question: .two, cardSelection: .two)
}
#Preview {
    PlayerHandView(hand: [
        PlayingCard(value: .ace, suit: .hearts),
        PlayingCard(value: .eight, suit: .clubs),
        PlayingCard(value: .king, suit: .diamonds),
        PlayingCard(value: .ten, suit: .spades)
    ], question: .three, cardSelection: .three)
}
#Preview {
    PlayerHandView(hand: [
        PlayingCard(value: .ace, suit: .hearts),
        PlayingCard(value: .eight, suit: .clubs),
        PlayingCard(value: .king, suit: .diamonds),
        PlayingCard(value: .ten, suit: .spades)
    ], question: .four, cardSelection: .four)
}
