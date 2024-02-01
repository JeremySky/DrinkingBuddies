//
//  ModifyUser.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/11/23.
//

import SwiftUI

struct ModifyUser: View {
    @State var user: User
    @Binding var users: [User]
    var saveAction: (User) -> Void
    var buttonIsDisabled: Bool { !user.isValid() }
    
    var body: some View {
        ZStack {
            VStack {
                GameHeader(
                    user: user,
                    main: { FormHeader(user: $user) })
                Spacer()
            }
            
            VStack {
                CustomColorPicker(user: $user, users: $users)
                IconPicker(user: $user, users: $users)
            }
            
            VStack {
                Spacer()
                Button(action: {
                    saveAction(user)
                }, label: {
                    Text("Save")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(buttonIsDisabled ? .gray.opacity(0.4) : user.color.value)
                        .cornerRadius(10)
                        .padding()
                })
                .disabled(!user.isValid())
            }
        }
    }
}

#Preview {
    @State var user = User()
    @State var users = [User]()
    return ModifyUser(user: user, users: $users) { _ in }
}
