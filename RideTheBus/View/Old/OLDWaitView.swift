//
//  WaitView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct OLDWaitView: View {
    @EnvironmentObject var game: OLDGameViewModel
    @Binding var player: OLDPlayer
    @State var selected: Selection?
    
    var body: some View {
        VStack {
            //MARK: -- TITLE
            VStack {
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
                    VStack {
                        Text("\(game.currentPlayer.name)'s Turn")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundStyle(.white)
                        Text("Cards Left: \(game.deck.pile.count)")
                            .foregroundStyle(.white)
                    }
                }
            }
            .padding(.bottom)
            .frame(maxWidth: .infinity)
            .background(game.currentPlayer.color)
            
            
            //MARK: -- BODY
            ScrollView {
                Spacer()
                    .frame(height: 10)
                ForEach($game.players.indices, id: \.self) { i in
                    ZStack(alignment: .topTrailing) {
                        PlayerOverview(player: $game.players[i], highlightPlayer: true)
                            .padding(.horizontal)
                            .disabled(true)
                        
                        if game.players[i].pointsToTake > 0 {
                            ZStack {
                                Ellipse()
                                    .fill(.white)
                                    .stroke(.black, lineWidth: 3)
                                Text("Take")
                                    .font(.title2)
                                    .fontWeight(.black)
                                    .foregroundStyle(.black)
                            }
                            .frame(width: 80, height: 65)
                            .padding([.top, .trailing], 20)
                            .rotationEffect(.degrees(18))
                            .scaleEffect(game.players[i].pointsToGive > 0 ? 0.6 : 1)
                            .offset(x: game.players[i].pointsToGive > 0 ? 30 : 0, y:  game.players[i].pointsToGive > 0 ? -20 : 0)
                        }
                        
                        if game.players[i].pointsToGive > 0 {
                            ZStack {
                                Ellipse()
                                    .fill(.white)
                                    .stroke(.black, lineWidth: 3)
                                Text("Give")
                                    .font(.title2)
                                    .fontWeight(.black)
                                    .foregroundStyle(.black)
                            }
                            .frame(width: 80, height: 65)
                            .padding([.top, .trailing], 20)
                            .rotationEffect(.degrees(18))
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
    enum Selection {
        case one, two, three, four
    }
}










//MARK: -- PREVIEWS
#Preview {
    @State var player = OLDPlayer.test1
    return OLDWaitView(player: $player)
        .environmentObject(OLDGameViewModel.preview)
}
