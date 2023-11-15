//
//  TakeView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct TakeView: View {
    @State var points: Int
    let player: Player
    var changePhaseAction: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("\(points)")
                    .font(.system(size: 200))
                    .fontWeight(.semibold)
                Spacer()
                VStack {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 65, height: 65)
                                .foregroundStyle(Color.white)
                                .shadow(radius: 10)
                            Text("\(player.points)")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                        }
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
                    .padding([.horizontal, .bottom])
                }
            }
            
//            if points == 0 {
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
//            }
        }
    }
}

#Preview {
    TakeView(points: 10, player: Player.test1) {}
}
