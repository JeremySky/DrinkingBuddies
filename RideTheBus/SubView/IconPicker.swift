//
//  IconPicker.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/18/23.
//

import SwiftUI

struct IconPicker: View {
    @Binding var user: User
    @Binding var users: [User]
    var takenIcons: [IconSelection] { users.map({$0.icon}) }
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer()
                    .frame(width: 10)
                ForEach(IconSelection.allCases, id: \.self) { icon in
                    if !takenIcons.contains(icon) {
                        Button {
                            user.icon = icon
                        } label: {
                            UserIcon(icon: icon, color: user.color, weight: .semibold, isSelected: user.icon == icon)
                                .frame(width: 80, height: 80)
                                .padding(.vertical)
                        }
                        .foregroundStyle(user.color.value)
                    }
                }
                Spacer()
                    .frame(width: 10)
            }
        }
    }
}

#Preview {
    @State var user = User()
    return IconPicker(user: $user, users: .constant([]))
}
