//
//  PlayerOverView.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/14/23.
//

import SwiftUI

struct PlayerOverView: View {
    @Binding var player: Player
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 8)
                    .frame(height: 160)
                    .foregroundStyle(player.color.value.opacity(0.65))
                HStack {
                    Group {
                        ForEach(0..<4) { i in
                            if player.hand[i].isFlipped {
                                MiniCardFront(card: player.hand[i], playerColor: player.color.value)
                            } else {
                                MiniCardBack(playerColor: .clear)
                            }
                        }
                    }
                    .padding(.horizontal, 5)
                }
                .padding(.bottom)
                .padding(.horizontal)
            }
            
            
            ZStack {
                ZStack(alignment: .bottom) {
                    Rectangle()
                        .frame(height: 44)
                        .foregroundStyle(player.color.value)
                    HStack(alignment: .top, spacing: 0) {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 5, height: 15)
                            .foregroundStyle(.white)
                        RoundedRectangle(cornerRadius: 8)
                            .frame(height: 55)
                            .foregroundStyle(player.color.value)
                    }
                }
                ZStack {
                    Circle()
                        .stroke(player.color.value, lineWidth: 31)
                        .fill(Color.white)
                        .frame(width: 50, height: 50)
                    UserIcon(user: player.user, size: .medium)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .offset(x: -4.5, y: -15)
                Text(player.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
            }
            
            ZStack {
                if player.pointsToTake > 0 {
                    ZStack {
                        Ellipse()
                            .fill(.white)
                            .stroke(.black, lineWidth: 3)
                        Text("Take")
                            .font(.title2)
                            .fontWeight(.black)
                            .foregroundStyle(.black)
                    }
                    .frame(width: 80, height: 65)
                    .padding([.top, .trailing], 20)
                    .rotationEffect(.degrees(18))
                    .scaleEffect(player.pointsToGive > 0 ? 0.6 : 1)
                    .offset(x: player.pointsToGive > 0 ? 30 : 0, y:  player.pointsToGive > 0 ? -20 : 0)
                }
                
                if player.pointsToGive > 0 {
                    ZStack {
                        Ellipse()
                            .fill(.white)
                            .stroke(.black, lineWidth: 3)
                        Text("Give")
                            .font(.title2)
                            .fontWeight(.black)
                            .foregroundStyle(.black)
                    }
                    .frame(width: 80, height: 65)
                    .padding([.top, .trailing], 20)
                    .rotationEffect(.degrees(18))
                }
            }
            .offset(y: -30)
        }
    }
}

#Preview {
    @State var player = Player.previewWithPoints
    return VStack {
        Text("\(player.pointsToGive)")
        Text("\(player.pointsToTake)")
        PlayerOverView(player: $player)
            .padding()
    }
}
