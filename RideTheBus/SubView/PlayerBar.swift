//
//  PlayerBar.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/16/23.
//

import SwiftUI

struct PlayerBar: View {
    var player: Player
    var body: some View {
        HStack {
            UserIcon(user: player.user, size: .small)
            Text(player.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.vertical)
        }
        .offset(x: -5)
        .frame(maxWidth: .infinity)
        .background(player.color.value)
        .cornerRadius(5)
    }
}

#Preview {
    PlayerBar(player: Player(user: User.test1))
        .padding()
}
