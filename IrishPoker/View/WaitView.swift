//
//  WaitView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct WaitView: View {
    var players: [Player] = [Player.test1, Player.test2, Player.test3, Player.test4]
    @State var selected: Selection?
    var zIndexArr: [Double] {
        switch selected {
        case .one:
            [2, 1, 1, 1]
        case .two:
            [1, 2, 1, 1]
        case .three:
            [1, 1, 2, 1]
        case .four:
            [1, 1, 1, 2]
        case nil:
            [2, 2, 2, 2]
        }
    }
    
    var body: some View {
        ZStack {
            //MARK: -- TITLE
            HStack {
                Image(systemName: "graduationcap")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Jeremy's Turn")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .offset(x: -5)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            
            
            //MARK: -- BODY
            VStack(spacing: 8) {
                Spacer()
                    .frame(height: 70)
                ForEach(players.indices, id: \.self) { i in
                    let player = players[i]
                    PlayerShowHandButton(player: player)
                }
            }
            .padding(.horizontal)
        }
    }
    
    enum Selection {
        case one, two, three, four
    }
}




//MARK: -- PlayerShowHandButton struct
struct PlayerShowHandButton: View {
    let player: Player
    @State var showHand: Bool = false
    
    
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
                        .shadow(radius: 10)
                    HStack {
                        Group {
                            SmallCard(card: player.hand[0], playerColor: player.color, startFaceUp: true)
                            SmallCard(card: player.hand[1], playerColor: player.color, startFaceUp: false)
                            SmallCard(card: player.hand[2], playerColor: player.color, startFaceUp: true)
                            SmallCard(card: player.hand[3], playerColor: player.color, startFaceUp: true)
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
                    .foregroundStyle(/*showHand ? */player.color /*: player.color.opacity(0.9)*/)
                ZStack {
                    Circle()
                        .stroke(player.color, lineWidth: showHand ? 31 : 0)
                        .fill(Color.white)
                        .frame(width: 50, height: 50)
                    Image(systemName: player.icon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 38, height: 38)
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
    }
}







//MARK: -- PREVIEWS
#Preview {
    WaitView()
}
