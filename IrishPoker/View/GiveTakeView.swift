//
//  GiveTakeView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct GiveTakeView: View {
    @Binding var cards: (one: Card, two: Card)
    @State var tappable = (one: true, two: true)
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
                BigCard(card: $cards.one, tappable: $tappable.one) {}
                    .scaleEffect(0.55)
                    .frame(height: 280)
                BigCard(card: $cards.two, tappable: $tappable.two) {}
                    .scaleEffect(0.55)
                    .frame(height: 280)
            }
        }
    }
}

#Preview {
    @State var cards = (one: Card.test1, two: Card.test2)
    return GiveTakeView(cards: $cards)
}
