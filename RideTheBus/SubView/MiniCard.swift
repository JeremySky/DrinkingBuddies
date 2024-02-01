//
//  MiniCard.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/14/23.
//

import SwiftUI

struct MiniCardFront: View {
    let card: Card
    var playerColor: Color? = nil
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
    var playerColor: Color?
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

struct MiniCardHidden: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .strokeBorder(style: StrokeStyle(lineWidth: 5, dash: [10]))
            .frame(width: 65, height: 70)
    }
}

struct MiniCardResult: View {
    var result: Bool
    var body: some View {
        ZStack {
            MiniCardHidden()
            Image(systemName: result ? "checkmark" : "xmark")
                .resizable()
                .scaledToFit()
                .bold()
                .foregroundStyle(result ? .green : .red)
                .frame(width: 45, height: 45)
                .padding(.horizontal, 5)
        }
    }
}

#Preview {
    return VStack {
        MiniCardFront(card: Card.test1, playerColor: .blue)
        MiniCardBack(playerColor: .blue)
        MiniCardHidden()
    }
}
