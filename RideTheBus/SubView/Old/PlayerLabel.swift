//
//  PlayerLabel.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/27/23.
//

import SwiftUI

struct PlayerLabel: View {
    let player: Player
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 65)
                .foregroundStyle(player.color)
                .shadow(radius: 10)
            HStack {
                ZStack {
                    Circle()
                        .frame(width: 45, height: 45)
                        .foregroundStyle(Color.white)
                    Image(systemName: player.icon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .foregroundStyle(player.color)
                    Image(systemName: player.icon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .foregroundStyle(.black.opacity(0.3))
                }
                Spacer()
                Text(player.name)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    PlayerLabel(player: Player.test1)
}
