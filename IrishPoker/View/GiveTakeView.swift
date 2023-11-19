//
//  GiveTakeView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct GiveTakeView: View {
    @Binding var card1: Card
    @Binding var card2: Card
    @State var tappable1: Bool = true
    @State var tappable2: Bool = true
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
                BigCard(card: $card1, tappable: $tappable1) {}
                    .scaleEffect(0.55)
                    .frame(height: 280)
                BigCard(card: $card2, tappable: $tappable2) {}
                    .scaleEffect(0.55)
                    .frame(height: 280)
            }
        }
    }
}

#Preview {
    @State var cards = (one: Card.test1, two: Card.test2)
    return GiveTakeView(card1: $cards.one, card2: $cards.two)
}
