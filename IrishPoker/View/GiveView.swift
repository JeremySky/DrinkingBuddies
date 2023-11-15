//
//  DistributePointsView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct GiveView: View {
    @State var points: Int
    var changePhaseAction: () -> Void
    
    
    @State var players: [Player] = [
        Player.test1,
        Player.test2,
        Player.test3,
        Player.test4
        ]
    
    func givePoints(to player: inout Player) {
        player.points += 1
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
                                Text("\(players[i].points)")
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                            }
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
                            .onTapGesture {
                                if points > 0 {
                                    givePoints(to: &players[i])
                                }
                            }
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            
            if points == 0 {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white)
                        .shadow(radius: 10)
                    HStack {
                        Image(systemName: "arrow.right")
                            .foregroundStyle(.blue)
                            .font(.system(size: 60))
                            .fontWeight(.black)
                        Text("NEXT")
                            .font(.system(size: 50))
                            .fontWeight(.black)
                            .offset(x: -12)
                    }
                }
                .frame(height: 80)
                .padding()
                .onTapGesture {
                    changePhaseAction()
                }
            }
        }
    }
}

#Preview {
    GiveView(points: 10) {}
}
