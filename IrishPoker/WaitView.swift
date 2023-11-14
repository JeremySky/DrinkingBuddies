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
        //MARK: -- TITLE
        VStack{
            HStack {
                Image(systemName: "graduationcap")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Jeremy's Turn")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .offset(x: -5)
            }
            .padding()
            Spacer()
            
            
            //MARK: -- BODY
            VStack(spacing: 0) {
                
                
                ForEach(players.indices, id: \.self) { i in
                    let player = players[i]
                    
                    //MARK: --PLAYERS BUTTON
                    PlayerShowHandButton(player: player)
                }
                .padding(.bottom)
            }
            .padding(.horizontal)
        }
    }
}





struct PlayerShowHandButton: View {
    let player: Player
    @State var showHand: Bool = false
    let extraSpace: CGFloat = 70
    var body: some View {
        ZStack(alignment: .top) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: extraSpace)
                    .foregroundStyle(player.color)
                HStack {
                    ZStack {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(Color.white)
                        Image(systemName: player.icon.rawValue)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 38, height: 38)
                    }
                    Spacer()
                    Text(player.name)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                    Spacer()
                }
                .padding(.horizontal)
            }
            .zIndex(1)
            .onTapGesture {
                showHand.toggle()
            }
            
            
            //MARK: -- PLAYERS' HAND EXTENSION
            if showHand {
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: extraSpace + 100)
                        .foregroundStyle(player.color.opacity(0.7))
                        .shadow(radius: 10)
                    HStack {
                        
                        //MARK: -- MINI CARDS
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 65, height: 70)
                                .foregroundStyle(.white)
                                .shadow(color: player.color == .black ? .white : .black, radius: 5)
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
                    .padding(.bottom)
                    .padding(.horizontal)
                }
            }
            
            
            
            
        }
    }
}













//MARK: -- PREVIEWS
#Preview {
    WaitView()
}
