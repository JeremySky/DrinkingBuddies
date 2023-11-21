//
//  DistributePointsView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct GiveView: View {
    @Binding var player: Player
    @State var points: Int
    @State var players: [Player]
    var giveAction: ([Player]) -> Void
    @State var disableButtons: Bool = false
    
    func givePoints(to player: inout Player) {
        player.pointsToTake += 1
        self.player.pointsToGive -= 1
        points -= 1
    }
    var body: some View {
        ZStack {
            //MARK: -- GIVE
            VStack {
                Spacer()
                Text("\(points)")
                    .font(.system(size: 200))
                    .fontWeight(.semibold)
                Spacer()
                VStack {
                    ForEach(players.indices, id: \.self) { i in
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 65, height: 65)
                                    .foregroundStyle(Color.white)
                                    .shadow(radius: 10)
                                Text("\(players[i].pointsToTake)")
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                            }
                            
                            Button {
                                if points > 0 {
                                    givePoints(to: &players[i])
                                }
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(height: 65)
                                        .foregroundStyle(players[i].color)
                                        .shadow(radius: 10)
                                    HStack {
                                        ZStack {
                                            Circle()
                                                .frame(width: 45, height: 45)
                                                .foregroundStyle(Color.white)
                                            Image(systemName: players[i].icon.rawValue)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 35, height: 35)
                                                .foregroundStyle(players[i].color)
                                            Image(systemName: players[i].icon.rawValue)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 35, height: 35)
                                                .foregroundStyle(.black.opacity(0.3))
                                        }
                                        Spacer()
                                        Text(players[i].name)
                                            .font(.largeTitle)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color.white)
                                        Spacer()
                                    }
                                    .padding()
                                }
                            }
                            .disabled(disableButtons)
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
            }
            
            if points == 0 {
                Button("Next", action: { giveAction(players) })
                    .buttonStyle(.next)
                    .onAppear {
                        disableButtons = true
                }
            }
        }
    }
}

#Preview {
    @State var player = Player.give
    @State var players = Player.testArr
    return GiveView(player: $player, points: player.pointsToGive, players: players, giveAction: {_ in })
}
