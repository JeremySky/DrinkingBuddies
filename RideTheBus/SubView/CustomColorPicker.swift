//
//  ColorPicker.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/18/23.
//

import SwiftUI


struct CustomColorPicker: View {
    @Binding var user: User
    @Binding var users: [User]
    var takenColors: [ColorSelection] { users.map({$0.color}) }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer()
                    .frame(width: 10)
                ForEach(ColorSelection.allCases, id: \.self) { color in
                    if !takenColors.contains(color) {
                        Button {
                            user.color = color
                        } label: {
                            Circle()
                                .foregroundStyle(color.value)
                                .frame(width: user.color == color ? 65 : 50, height: 90)
                                .shadow(color: user.color == color ? .yellow : .clear, radius: 10)
                        }
                    }
                }
                Spacer()
                    .frame(width: 10)
            }
        }
    }
}

#Preview {
    @State var users = User.testArr
    return VStack {
        CustomColorPicker(user: $users[0], users: $users)
    }
}
