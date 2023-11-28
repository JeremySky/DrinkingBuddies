//
//  PlayerResults.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/23/23.
//

import SwiftUI

struct PlayerResultsView: View {
    @State var player: Player
    
    var body: some View {
        VStack(spacing: 0) {
            PlayerHeader(player: $player)
            
            Text("Total score: \(player.score)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.bottom)
                .background(player.color)
            
            ScrollView {
                
                VStack {
                    Text("Guessing")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundStyle(player.color)
                        .padding(.bottom)
                    HStack {
                        ForEach(0..<4) { i in
                            VStack {
                                MiniCardFront(card: player.hand[i], playerColor: .clear)
                                    .padding(.horizontal, 5)
                                
                                ZStack {
                                    MiniCardBack(playerColor: .clear)
                                    Image(systemName: player.guesses[i] ? "checkmark" : "xmark")
                                        .resizable()
                                        .scaledToFit()
                                        .bold()
                                        .foregroundStyle(player.guesses[i] ? .green : .red)
                                        .frame(width: 45, height: 45)
                                        .padding(.horizontal, 5)
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 40)
                
                Divider()
                    .padding(.horizontal)
                
                
                VStack {
                    Text("Give")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundStyle(player.color)
                        .padding(.bottom)
                    
                    Text("Cards given:")
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    HStack(alignment: .top) {
                        ForEach(0..<4) { i in
                            VStack {
                                if player.hand[i].giveCards.isEmpty {
                                    MiniCardHidden()
                                        .padding(.horizontal, 5)
                                } else {
                                    ForEach(player.hand[i].giveCards, id: \.self) { card in
                                        MiniCardFront(card: card)
                                            .padding(.horizontal, 5)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.bottom, 25)
                    
                    Text("Points given to:")
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    ForEach(player.giveTo.indices) { i in
                        HStack {
                            PlayerLabel(player: player.giveTo[i].0)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 65, height: 65)
                                    .foregroundStyle(Color.white)
                                    .shadow(radius: 10)
                                Text("\(player.giveTo[i].1)")
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical, 40)
                
                
                Divider()
                    .padding(.horizontal)
                
                VStack {
                    Text("Take")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundStyle(player.color)
                        .padding(.bottom)
                    
                    Text("Cards taken:")
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    HStack(alignment: .top) {
                        ForEach(0..<4) { i in
                            VStack {
                                if player.hand[i].takeCards.isEmpty {
                                    MiniCardHidden()
                                        .padding(.horizontal, 5)
                                } else {
                                    ForEach(player.hand[i].takeCards, id: \.self) { card in
                                        MiniCardFront(card: card)
                                            .padding(.horizontal, 5)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.bottom, 25)
                    
                    Text("Points taken from:")
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    ForEach(player.takeFrom.indices) { i in
                        HStack {
                            PlayerLabel(player: player.takeFrom[i].0)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 65, height: 65)
                                    .foregroundStyle(Color.white)
                                    .shadow(radius: 10)
                                Text("\(player.takeFrom[i].1)")
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 30)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    @State var player = Player.results
    return PlayerResultsView(player: player)
}
