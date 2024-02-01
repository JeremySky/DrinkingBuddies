//
//  RootView.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/10/23.
//

import SwiftUI

struct RootView: View {
    @State var user: User?
    @State var newUser = User()
    @State var isModifyUserPresenting = false
    
    @AppStorage("user") private var userData: Data = Data()
    var body: some View {
        ZStack {
            if user == nil {
                WelcomeView()
                .onTapGesture {
                    isModifyUserPresenting = true
                }
            } else {
                MainView(user: user!)
            }
        }
        
        
        //MARK: -- ZSTACK {}
        .onAppear {
            guard let user = try? JSONDecoder().decode(User.self, from: userData) else { return }
            self.user = User(name: user.name, icon: user.icon, color: user.color)
        }
        .sheet(isPresented: $isModifyUserPresenting, content: {
            ModifyUser(user: newUser, users: .constant([])) { returnedUser in
                self.user = returnedUser
                
                if let userData = try? JSONEncoder().encode(returnedUser) {
                    self.userData = userData
                    isModifyUserPresenting = false
                }
            }
        })
    }
}

#Preview {
    RootView()
}

