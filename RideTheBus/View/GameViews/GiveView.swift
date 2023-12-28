//
//  GiveView.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/16/23.
//

import SwiftUI

struct GiveView: View {
    @EnvironmentObject var game: GameManager
    @State var pointsToGiveReference: Int
    @State var lobbyReference: Lobby
    @State var splitAvailable = false
    @State var splitBetween: [Bool] = [false, false, false, false]
    private var splitPoints: Int { pointsToGiveReference/splitBetween.filter{$0 == true}.count }
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                GameHeader(user: game.user, main: {DefaultHeader(user: game.user)})
                ZStack(alignment: .topTrailing) {
                    Text(String(pointsToGiveReference))
                        .font(.system(size: 130))
                        .fontWeight(.bold)
                        .onTapGesture {
                            if splitAvailable && splitBetween != [false, false, false, false] {
                                for i in splitBetween.indices {
                                    if splitBetween[i] {
                                        lobbyReference.players[i].pointsToTake += splitPoints
                                    }
                                }
                                pointsToGiveReference %= pointsToGiveReference/splitBetween.filter{$0 == true}.count
                                splitBetween = [false, false, false, false]
                                splitAvailable = false
                            }
                        }
                        .gesture(
                            LongPressGesture(minimumDuration: 0.7)
                                .onEnded { _ in
                                    if pointsToGiveReference > 1 {
                                        splitAvailable = true
                                    }
                                }
                        )
                        .rotationEffect(Angle(degrees: splitAvailable ? 8 : 0))
                        .animation(.linear.speed(1.8).repeatCount(splitAvailable ? .max : 0, autoreverses: true), value: splitAvailable)
                        .scaleEffect(splitAvailable ? 1.1 : 1)
                        .frame(maxWidth: .infinity)
                    
                    if splitAvailable {
                        Button {
                            splitBetween = [false, false, false, false]
                            splitAvailable = false
                        } label: {
                            Image(systemName: "person.fill.xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .foregroundStyle(.red)
                                .padding()
                        }
                    }
                }
                .frame(maxWidth: 230)
                
                ZStack {
                    Group{
                        if splitAvailable && splitBetween != [false, false, false, false] {
                            Text("Tap to split")
                                .offset(y: -20)
                        } else if pointsToGiveReference > 1 {
                            Text(!splitAvailable ? "Hold to split" : "Select players")
                                .offset(y: splitAvailable ? 5 : -20)
                                .animation(.easeIn, value: splitAvailable)
                        } else if pointsToGiveReference == 0 {
                            Text("Continue")
                        }
                    }
                    .font(.headline)
                    .foregroundStyle(.gray.opacity(0.4))
                }
                .frame(height: 30)
                
                
                VStack(spacing: 0) {
                    ScrollView {
                        ForEach(lobbyReference.players.indices, id: \.self) { i in
                            Button {
                                if !splitAvailable {
                                    if pointsToGiveReference > 0 {
                                        lobbyReference.players[i].pointsToTake += 1
                                        pointsToGiveReference -= 1
                                    }
                                } else {
                                    splitBetween[i].toggle()
                                }
                                
                            } label: {
                                HStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .frame(width: 65, height: 65)
                                            .foregroundStyle(Color.white)
                                            .shadow(color: splitBetween[i] ? .yellow : .gray, radius: 5)
                                        Group {
                                            if !splitAvailable {
                                                Text("\(lobbyReference.players[i].pointsToTake)")
                                            } else {
                                                if splitBetween[i] {
                                                    Text("\(splitPoints + lobbyReference.players[i].pointsToTake)")
                                                } else {
                                                    Text("\(lobbyReference.players[i].pointsToTake)")
                                                }
                                            }
                                        }
                                        .font(.largeTitle)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.black)
                                    }
                                    PlayerBar(player: lobbyReference.players[i])
                                        .padding(.leading)
                                        .shadow(radius: 6)
                                }
                            }
                            .padding([.top, .horizontal])
                            .padding(.horizontal, 10)
                        }
                        if pointsToGiveReference == 0 {
                            Spacer().frame(height: 100)
                        }
                        Spacer().frame(height: 100)
                    }
                }
            }
            
                VStack {
                    Spacer()
                    
                    Button {
                        game.givePointsTo(lobbyReference)
                    } label: {
                        Text("Next")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .background(pointsToGiveReference != 0 ? .gray : game.user.color.value)
                            .cornerRadius(10)
                            .shadow(color: .white.opacity(0.3), radius: 10)
                    }
                    .padding(.top, 60)
                    .padding(.horizontal)
                    .padding()
                    .disabled(pointsToGiveReference != 0)
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
    GiveView(pointsToGiveReference: 13, lobbyReference: Lobby.previewGameHasStarted)
        .environmentObject(GameManager.previewGameStarted)
}




//if splitAvailable {
//    Button {
//        for i in splitBetween.indices {
//            if splitBetween[i] {
//                lobbyReference.players[i].pointsToTake += splitPoints
//            }
//        }
//        pointsToGiveReference %= pointsToGiveReference/splitBetween.filter{$0 == true}.count
//        splitBetween = [false, false, false, false]
//        splitAvailable = false
//    } label: {
//        Text("Split")
//            .padding()
//            .frame(maxWidth: .infinity)
//            .foregroundStyle(.white)
//            .background(splitBetween.contains(true) ? game.user.color.value : .gray.opacity(0.4))
//            .cornerRadius(10)
//            .padding(.horizontal)
//    }
//    .padding()
//    .animation(.easeIn, value: splitAvailable)
//}
