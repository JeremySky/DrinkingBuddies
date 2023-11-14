//
//  WaitView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct WaitView: View {
    var players: [Player] = [Player.test1, Player.test2, Player.test3, Player.test4]
    
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
                ForEach(players, id: \.self) { player in
                    PlayerShowHandButton(player: player)
                }
            }
            .padding(.horizontal)
        }
    }
}




//MARK: -- PlayerShowHandButton struct
struct PlayerShowHandButton: View {
    let player: Player
    @State var showHand: Bool = true
    
    
    var body: some View {
        //aligned at top for front and back RoundedRectangles
        ZStack(alignment: .top) {
            
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
            .zIndex(1)
            .onTapGesture {
                showHand.toggle()
            }
            
            
            //MARK: -- PLAYERS' HAND EXTENSION
            if showHand {
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 70 + 80)
                        .foregroundStyle(player.color.opacity(0.65))
                        .shadow(radius: 10)
                    HStack {
                        Group {
                            MiniCard(player: player)
                            MiniCard(player: player)
                            MiniCard(player: player)
                            MiniCard(player: player)
                        }
                        .padding(.horizontal, 5)
                    }
                    .padding(.bottom)
                    .padding(.horizontal)
                }
            }
        }
    }
}


//MARK: -- MiniCard Struct
struct MiniCard: View {
    let player: Player
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 65, height: 70)
                .foregroundStyle(.white)
                .shadow(color: player.color == .black ? .white.opacity(0.5) : .black.opacity(0.75), radius: 5)
            Image(systemName: player.hand.two.suit.icon)
                .resizable()
                .padding(.all, 5)
                .frame(width: 63, height: 63)
                .foregroundStyle(player.hand.one.color)
            Text(player.hand.one.value.string)
                .font(.title)
                .bold()
                .foregroundStyle(.white)
        }
    }
}











//MARK: -- PREVIEWS
#Preview {
    WaitView()
}
