//
//  WaitView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct WaitView: View {
    @EnvironmentObject var game: GameViewModel
    @Binding var player: Player
    @State var selected: Selection?
    
    var body: some View {
        VStack {
            //MARK: -- TITLE
            HStack {
                ZStack {
                    Circle()
                        .fill(.white)
                    Image(systemName: game.currentPlayer.icon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .fontWeight(.heavy)
                        .foregroundStyle(game.currentPlayer.color)
                        .padding()
                    Image(systemName: game.currentPlayer.icon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .fontWeight(.heavy)
                        .foregroundStyle(.black.opacity(0.3))
                        .padding()
                }
                .frame(width: 100, height: 100)
                Text("\(game.currentPlayer.name)'s Turn")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
            }
            .padding(.bottom)
            .frame(maxWidth: .infinity)
            .background(game.currentPlayer.color)
            
            
            //MARK: -- BODY
            ScrollView {
                Spacer()
                    .frame(height: 10)
                ForEach($game.players.indices, id: \.self) { i in
                    PlayerOverview(player: $game.players[i], highlightPlayer: true)
                        .padding(.horizontal)
                }
            }
        }
        .onAppear {
            if player.id == game.currentPlayer.id {
                player.stage = .guess
            }
        }
    }
    enum Selection {
        case one, two, three, four
    }
}




//MARK: -- PlayerShowHandButton struct
struct PlayerOverview: View {
    @Binding var player: Player
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







//MARK: -- PREVIEWS
#Preview {
    @State var player = Player.test1
    return WaitView(player: $player)
        .environmentObject(GameViewModel.preview)
}
