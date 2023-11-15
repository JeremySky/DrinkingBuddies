//
//  GiveTakeView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct GiveTakeView: View {
    let cards: [Card] = Card.testHandArray1
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
                BigCard(card: cards[0], isTappable: $tappable.card1, startFaceUp: false)
                    .scaleEffect(0.55)
                    .frame(height: 280)
                BigCard(card: cards[1], isTappable: $tappable.card2, startFaceUp: false)
                    .scaleEffect(0.55)
                    .frame(height: 280)
            }
        }
    }
}

#Preview {
    GiveTakeView()
}
