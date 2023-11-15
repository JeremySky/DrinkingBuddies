//
//  SmallCard.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/14/23.
//

import SwiftUI


struct SmallCard: View {
    let card: Card
    let playerColor: Color
    let startFaceUp: Bool
    
    var body: some View {
        CardViewHelper(startFaceUp: startFaceUp) {
            MiniCardFront(card: card, playerColor: playerColor)
        } backView: {
            MiniCardBack(playerColor: playerColor)
        }
        
        
    }
}

struct MiniCardFront: View {
    let card: Card
    let playerColor: Color
    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 65, height: 70)
                    .foregroundStyle(.white)
                    .shadow(color: playerColor == .black ? .white.opacity(0.5) : .black.opacity(0.75), radius: 5)
                Image(systemName: card.suit.icon)
                    .resizable()
                    .padding(.all, 5)
                    .frame(width: 63, height: 63)
                    .foregroundStyle(card.color)
                Text(card.value.string)
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
            }
        }
    }
}

struct MiniCardBack: View {
    let playerColor: Color
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 65, height: 70)
                .foregroundStyle(.white)
                .shadow(color: playerColor == .black ? .white.opacity(0.5) : .black.opacity(0.75), radius: 5)
            Image("card.back")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 7))
        }
    }
}

#Preview {
    SmallCard(card: Card.test1, playerColor: Player.test1.color, startFaceUp: true)
}

#Preview {
    SmallCard(card: Card.test1, playerColor: Player.test1.color, startFaceUp: false)
}
