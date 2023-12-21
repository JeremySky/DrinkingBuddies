//
//  ResultsView.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/17/23.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var game: GameManager
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                GameHeader(user: game.user, main: { DefaultHeader(user: game.user) })
                ScrollView {
                    
                    
                    //MARK: -- GUESSING
                    VStack {
                        Text("Guessing")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundStyle(game.user.color.value)
                            .padding(.vertical)
                        HStack {
                            ForEach(0..<4) { i in
                                VStack {
                                    MiniCardFront(card: game.fetchUsersPlayerReference().hand[i], playerColor: .clear)
                                        .padding(.horizontal, 5)
                                    
                                    MiniCardResult(result: game.fetchUsersPlayerReference().guesses[i])
                                }
                            }
                        }
                        
                        Divider()
                            .padding(.top)
                            .padding(.horizontal)
                        
                        
                        
                        //MARK: -- GIVE
                        VStack {
                            Text("Give")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundStyle(game.user.color.value)
                                .padding(.bottom)
                            
                            Text("Cards given:")
                                .foregroundStyle(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            
                            HStack(alignment: .top) {
                                ForEach(0..<4) { i in
                                    VStack {
                                        if game.fetchUsersPlayerReference().hand[i].giveCards.isEmpty {
                                            MiniCardHidden()
                                                .padding(.horizontal, 5)
                                        } else {
                                            ForEach(game.fetchUsersPlayerReference().hand[i].giveCards, id: \.self) { card in
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
                            
                            ForEach(game.fetchUsersPlayerReference().givenTo.indices) { i in
                                HStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 65, height: 65)
                                            .foregroundStyle(Color.white)
                                            .shadow(radius: 10)
                                        Text("\(game.fetchUsersPlayerReference().givenTo[i].points)")
                                            .font(.largeTitle)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.black)
                                    }
                                    
                                    PlayerBar(player: game.lobby.players[i])
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top, 30)
                        
                        
                        Divider()
                            .padding(.top)
                            .padding(.horizontal)
                        
                        
                        //MARK: -- Take
                        VStack {
                            Text("Take")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundStyle(game.user.color.value)
                                .padding(.bottom)
                            
                            Text("Cards taken:")
                                .foregroundStyle(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            
                            HStack(alignment: .top) {
                                ForEach(0..<4) { i in
                                    VStack {
                                        if game.fetchUsersPlayerReference().hand[i].giveCards.isEmpty {
                                            MiniCardHidden()
                                                .padding(.horizontal, 5)
                                        } else {
                                            ForEach(game.fetchUsersPlayerReference().hand[i].giveCards, id: \.self) { card in
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
                            
                            ForEach(game.fetchUsersPlayerReference().takenFrom.indices) { i in
                                HStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 65, height: 65)
                                            .foregroundStyle(Color.white)
                                            .shadow(radius: 10)
                                        Text("\(game.fetchUsersPlayerReference().takenFrom[i].points)")
                                            .font(.largeTitle)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.black)
                                    }
                                    
                                    PlayerBar(player: game.lobby.players[i])
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top, 30)
                        .padding(.bottom, 40)
                        
                        
                        Spacer().frame(height: 90)
                    }
                }
            }
            VStack {
                Spacer()
                Button {
                    //
                } label: {
                    Text("Continue")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(game.user.color.value)
                        .cornerRadius(10)
                        .shadow(color: .white.opacity(0.3), radius: 10)
                }
                .padding(.top, 60)
                .padding(.horizontal)
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.white.opacity(0.8),
                            Color.clear
                        ]),
                        startPoint: .bottom,
                        endPoint: .top
                    ))
                    
            }
        }
    }
}

#Preview {
    ResultsView()
        .environmentObject(GameManager.previewResults)
}
