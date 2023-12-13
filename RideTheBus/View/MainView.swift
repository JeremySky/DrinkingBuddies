//
//  MainView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/20/23.
//

import SwiftUI



struct MainView: View {
    @StateObject var game: GameManager
    @State var isModifyUserPresenting = false
    
    @AppStorage("user") private var userData: Data = Data()
    var body: some View {
        ZStack {
            
            
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
                        
                    }, label: {
                        Text("Host")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .background(game.user.color.value)
                            .cornerRadius(10)
                    })
                    HStack {
                        JoinGameTextFieldAndButton(user: game.user)
                    }
                }
                .padding(.horizontal)
                
            }
            .padding()
        }
        .sheet(isPresented: $isModifyUserPresenting, content: {
            ModifyUser(user: game.user, users: .constant([])) { returnedUser in
                game.updateUser(to: returnedUser)
                
                if let userData = try? JSONEncoder().encode(returnedUser) {
                    self.userData = userData
                    isModifyUserPresenting = false
                }
            }
        })
    }
}

#Preview {
    @State var user: User = User.test1
    return MainView(user: user)
}

extension MainView {
    init(user: User) {
        self._game = StateObject(wrappedValue: GameManager(user: user))
    }
}




enum AppViewSelection {
    case setup
    case game
}
