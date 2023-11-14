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
    let currentUsersPlayerNum: PlayerNumber = .one
    
    func givePoint(to player: inout Player) {
        player.points += 1
        points -= 1
    }
    func take() {
        switch currentUsersPlayerNum {
        case .one:
            players[0].points += points
        case .two:
            players[1].points += points
        case .three:
            players[2].points += points
        case .four:
            players[3].points += points
        }
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
                                            .frame(width: 50, height: 50)
                                            .foregroundStyle(Color.white)
                                        Image(systemName: players[i].icon.rawValue)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 38, height: 38)
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
                                    givePoint(to: &players[i])
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
