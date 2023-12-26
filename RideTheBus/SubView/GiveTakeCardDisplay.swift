//
//  GiveTakeCardDisplay.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/14/23.
//

import SwiftUI

struct GiveTakeCardDisplay: View {
    @EnvironmentObject var game: GameManager
    @State var card1: Card
    @State var card2: Card
    @Binding var firstPick: CardValue?
    @Binding var secondPick: CardValue?

    @GestureState private var translation1: CGFloat = 0
    @GestureState private var translation2: CGFloat = 0
    @State private var showingCard2 = false

    @State private var offset1: CGFloat = 0
    @State private var offset2: CGFloat = 0
    
    
    
    
    var body: some View {
        let dragGesture1 = DragGesture()
            .updating($translation1) { value, state, _ in
                state = value.translation.width
                offset1 = state + 5
            }
            .onEnded { value in
                let threshold: CGFloat = 40
                if value.translation.width < threshold {
                    withAnimation {
                        showingCard2 = true
                    }
                } else if value.translation.width > -threshold {
                    withAnimation {
                        showingCard2 = false
                    }
                }
                offset1 = 0
            }

        let dragGesture2 = DragGesture()
            .updating($translation2) { value, state, _ in
                state = value.translation.width
                offset2 = state - 5
            }
            .onEnded { value in
                let threshold: CGFloat = 40
                if value.translation.width < threshold {
                    withAnimation {
                        showingCard2 = true
                    }
                } else if value.translation.width > -threshold {
                    withAnimation {
                        showingCard2 = false
                    }
                }
                offset2 = 0
            }

        
        
        
        //MARK: -- RETURNED VIEW
        return VStack {
            Spacer()
            ZStack {
                BigCard(card: card1, tappable: .constant(true)) {
                    game.checkForGiveAndTake(card1, &firstPick, &secondPick)
                }
                .offset(x: showingCard2 ? -UIScreen.main.bounds.width : offset1)
                .gesture(dragGesture1)
                .animation(.easeInOut, value: showingCard2)
                
                BigCard(card: card2, tappable: .constant(true)) {
                    game.checkForGiveAndTake(card2, &firstPick, &secondPick)
                }
                .offset(x: showingCard2 ? offset2 : UIScreen.main.bounds.width + translation2)
                .gesture(dragGesture2)
                .animation(.easeInOut, value: showingCard2)
            }
            .zIndex(1)
            .padding()
            
            
            
            HStack {
                Group {
                    Circle()
                        .foregroundStyle(!showingCard2 ? game.user.color.value : .gray.opacity(0.4))
                    Circle()
                        .foregroundStyle(showingCard2 ? game.user.color.value : .gray.opacity(0.4))
                }
                .frame(width: 10)
            }
            
            Spacer()
        }
    }
}

struct GiveTakeCardDisplay_Previews: PreviewProvider {
    @State static var card1 = Card(value: CardValue.ace, suit: CardSuit.clubs)
    @State static var card2 = Card(value: CardValue.ten, suit: CardSuit.hearts)
    @State static var firstPick: CardValue? = nil
    @State static var secondPick: CardValue? = nil

    static var previews: some View {
        GiveTakeCardDisplay(card1: card1, card2: card2, firstPick: $firstPick, secondPick: $secondPick)
            .environmentObject(GameManager.previewGameStarted)
    }
}
