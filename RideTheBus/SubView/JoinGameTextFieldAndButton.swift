//
//  JoinGame.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/11/23.
//

import SwiftUI

struct JoinGameTextFieldAndButton: View {
    @Binding var gameID: [String]
    @FocusState private var fieldFocus: Int?
    @State var oldValue = ""
    
    var body: some View {
        HStack {
            ForEach(0..<5) { i in
                TextField("X", text: $gameID[i], onEditingChanged: { editing in
                    if editing {
                        oldValue = gameID[i]
                    }
                })
                .textCase(.uppercase)
                .frame(width: 40, height: 50)
                .multilineTextAlignment(.center)
                .background(.gray.opacity(0.4))
                .cornerRadius(10)
                .focused($fieldFocus, equals: i)
                .tag(i)
                .onChange(of: gameID[i]) { _, newValue in
                    if gameID[i].count > 1 {
                        let currentValue = Array(gameID[i])
                        
                        if currentValue[0] == Character(oldValue) {
                            gameID[i] = String(gameID[i].suffix(1))
                        } else {
                            gameID[i] = String(gameID[i].prefix(1))
                        }
                    }
                    if !newValue.isEmpty {
                        if i == gameID.count - 1 {
                            fieldFocus = gameID.count
                        } else {
                            fieldFocus = (fieldFocus ?? 0) + 1
                        }
                    } else {
                        fieldFocus = (fieldFocus ?? 0) - 1
                    }
                }
            }
        }
    }
}


#Preview {
    @State var gameID = ["", "", "", "", ""]
    return JoinGameTextFieldAndButton(gameID: $gameID)
        .padding()
}


