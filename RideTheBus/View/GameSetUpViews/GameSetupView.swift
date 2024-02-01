//
//  SetupView.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/12/23.
//

import SwiftUI

struct GameSetupView: View {
    @EnvironmentObject var game: GameManager
    @State var joinedGame = false
    @State var isModifyUserPresenting = false
    @State var gameID = ["", "", "", "", ""]
    
    @AppStorage("user") private var userData: Data = Data()
    var body: some View {
        ZStack {
            if !joinedGame {
                //MARK: -- HEADER
                VStack {
                    Button {
                        isModifyUserPresenting = true
                    } label: {
                        GameHeader(user: game.user, main: { DefaultHeader(user: game.user) })
                    }
                    Spacer()
                }
                
                
                
                //MARK: -- TITLE / LOGO
                Text("Drinking \nBuddies")
                    .font(.system(size: 75))
                    .fontWeight(.black)
                    .multilineTextAlignment(.center)
                
                
                
                //MARK: -- ACTION BUTTONS
                VStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            game.createNewGame()
                            joinedGame = true
                        }, label: {
                            Text("Host")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(.white)
                                .background(game.user.color.value)
                                .cornerRadius(10)
                        })
                        HStack {
                            JoinGameTextFieldAndButton(gameID: $gameID)
                            Button("Join", action: {
                                game.didJoinGame(gameID.joined()) { didJoin in
                                    joinedGame = didJoin
                                    
                                    print(joinedGame)
                                }
                                gameID = ["", "", "", "", ""]
                                //                                joinedGame = true
                            })
                                .foregroundColor(game.user.color.value)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(game.user.color.value)
                                )
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
                
                
            } else {
                NewGameView(joinedGame: $joinedGame)
            }
        }
        
        
        //MARK: -- ZSTACK {}
        .sheet(isPresented: $isModifyUserPresenting, content: {
            ModifyUser(user: game.user, users: .constant([])) { returnedUser in
                game.updateUser(to: returnedUser)
                
                if let userData = try? JSONEncoder().encode(returnedUser) {
                    self.userData = userData
                }
                isModifyUserPresenting = false
            }
        })
    }
}

#Preview {
    GameSetupView()
        .environmentObject(GameManager.previewSetUp)
}


    


