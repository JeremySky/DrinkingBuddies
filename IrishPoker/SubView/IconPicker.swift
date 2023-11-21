//
//  IconPicker.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/18/23.
//

import SwiftUI

struct IconPicker: View {
    @Binding var selectedIcon: IconSelection
    @Binding var color: Color
    @Binding var players: [Player]
    var takenIcons: [IconSelection] { players.map({$0.icon}) }
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer()
                    .frame(width: 10)
                ForEach(IconSelection.allCases, id: \.self) { icon in
                    if !takenIcons.contains(icon) {
                        Button {
                            selectedIcon = icon
                        } label: {
                            PlayerIcon(icon: icon, color: color, weight: .semibold, selected: selectedIcon == icon)
                                .frame(width: 80, height: 80)
                                .padding(.vertical)
                        }
                        .foregroundStyle(color)
                    }
                }
                Spacer()
                    .frame(width: 10)
            }
        }
    }
}

#Preview {
    @State var icon: IconSelection = .backpack
    @State var color: Color = .red
    return IconPicker(selectedIcon: $icon, color: $color, players: .constant([]))
}
