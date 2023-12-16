//
//  OLDPlayerOverview.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/20/23.
//

import SwiftUI


//MARK: -- PlayerShowHandButton struct
struct OLDPlayerOverview: View {
    @Binding var player: OLDPlayer
    @State var showHand: Bool = true
    var highlightPlayer: Bool
    
    
    var body: some View {
        //aligned at top for front and back RoundedRectangles
        ZStack(alignment: .top) {
            
            //MARK: -- PLAYERS' HAND EXTENSION
            if showHand {
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 70 + 80)
                        .foregroundStyle(.white.opacity(0.9))
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 70 + 80)
                        .foregroundStyle(player.color.opacity(0.65))
                    HStack {
                        Group {
                            ForEach(0..<4) { i in
                                if player.hand[i].isFlipped {
                                    MiniCardFront(card: player.hand[i], playerColor: player.color)
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
            }
            
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: showHand ? 50 : 70)
                    .foregroundStyle(player.color)
                ZStack {
                    Circle()
                        .stroke(player.color, lineWidth: showHand ? 31 : 0)
                        .fill(Color.white)
                        .frame(width: 50, height: 50)
                    Image(systemName: player.icon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 38, height: 38)
                        .foregroundStyle(player.color)
                    Image(systemName: player.icon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 38, height: 38)
                        .foregroundStyle(.black.opacity(0.3))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .offset(y: showHand ? -16 : 0)
                Text(player.name)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
            }
            .onTapGesture {
                showHand.toggle()
            }
        }
        .padding(.top, showHand ? 30 : 0)
    }
}

#Preview {
    @State var player = OLDPlayer.test1
    return OLDPlayerOverview(player: $player, showHand: true, highlightPlayer: true)
}
