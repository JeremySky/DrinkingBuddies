//
//  TakeView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct TakeView: View {
    @Binding var player: Player
    @State var points: Int
    var takeAction: () -> Void
    
    @State var startCountdown = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            VStack {
                //MARK: -- TITLE
                ZStack {
                    Circle()
                        .fill(.white)
                    Image(systemName: player.icon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .fontWeight(.heavy)
                        .foregroundStyle(player.color)
                        .padding()
                    Image(systemName: player.icon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .fontWeight(.heavy)
                        .foregroundStyle(.black.opacity(0.3))
                        .padding()
                }
                .frame(width: 100, height: 100)
                .padding(.bottom)
                .frame(maxWidth: .infinity)
                .background(player.color)
                
                Spacer()
                Text("\(points)")
                    .font(.system(size: 200))
                    .fontWeight(.semibold)
                Spacer()
                
                ZStack() {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white)
                        .shadow(radius: 10)
                    HStack {
                        Image(systemName: "flag.2.crossed.fill")
                            .foregroundStyle(.black, .red)
                            .font(.system(size: 40))
                            .fontWeight(.black)
                        Text("Start")
                            .font(.system(size: 50))
                            .fontWeight(.black)
                            .padding(.trailing)
                    }
                }
                .frame(height: 80)
                .padding()
                .onTapGesture {
                    startCountdown = true
                }
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
                    takeAction()
                    player.pointsTake = 0
                }
            }
        }
        .onReceive(timer) { time in
            if startCountdown && points > 0  {
                points -= 1
            }
        }
    }
}

#Preview {
    @State var player = Player.take
    return TakeView(player: $player, points: player.pointsTake) {}
}
