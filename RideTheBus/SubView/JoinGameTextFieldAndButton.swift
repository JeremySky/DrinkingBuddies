//
//  JoinGame.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/11/23.
//

import SwiftUI

struct JoinGameTextFieldAndButton: View {
    var user: User
    @State var roomID = ["", "", "", "", ""]
    @FocusState private var fieldFocus: Int?
    @State var oldValue = ""
    
    var body: some View {
        HStack {
            ForEach(0..<5) { i in
                TextField("X", text: $roomID[i], onEditingChanged: { editing in
                    if editing {
                        oldValue = roomID[i]
                    }
                })
                .textCase(.uppercase)
                .frame(width: 40, height: 50)
                .multilineTextAlignment(.center)
                .background(.gray.opacity(0.4))
                .cornerRadius(10)
                .focused($fieldFocus, equals: i)
                .tag(i)
                .onChange(of: roomID[i]) { newValue in
                    if roomID[i].count > 1 {
                        let currentValue = Array(roomID[i])
                        
                        if currentValue[0] == Character(oldValue) {
                            roomID[i] = String(roomID[i].suffix(1))
                        } else {
                            roomID[i] = String(roomID[i].prefix(1))
                        }
                    }
                    if !newValue.isEmpty {
                        if i == roomID.count - 1 {
                            fieldFocus = roomID.count
                        } else {
                            fieldFocus = (fieldFocus ?? 0) + 1
                        }
                    } else {
                        fieldFocus = (fieldFocus ?? 0) - 1
                    }
                }
            }
            
            Button("Join", action: {})
                .foregroundColor(user.color.value)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(user.color.value)
                )
        }
    }
}


#Preview {
    return JoinGameTextFieldAndButton(user: User.test1)
        .padding()
}


