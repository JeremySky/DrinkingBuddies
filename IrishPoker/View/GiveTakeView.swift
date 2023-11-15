//
//  GiveTakeView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct GiveTakeView: View {
    let cards: [PlayingCard] = PlayingCard.testHandArray
    @State var tappable: (card1: Bool, card2: Bool) = (true, true)
    var body: some View {
        ZStack {
            VStack {
                Group {
                    Text("Choose a card \nto be GIVE")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Text("The other will be TAKE")
                        .font(.headline)
                }
                .multilineTextAlignment(.center)
                Card(value: cards[0], tappable: $tappable.card1, faceUp: false) {
                    
                }
                    .scaleEffect(0.55)
                    .frame(height: 280)
                Card(value: cards[0], tappable: $tappable.card2, faceUp: false)
                    .scaleEffect(0.55)
                    .frame(height: 280)
            }
        }
        .onAppear {
            print(tappable)
        }
    }
}

#Preview {
    GiveTakeView()
}
