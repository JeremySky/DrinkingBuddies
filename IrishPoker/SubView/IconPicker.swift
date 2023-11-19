//
//  IconPicker.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/18/23.
//

import SwiftUI

struct IconPicker: View {
    @Binding var selectedIcon: Icon
    @Binding var color: Color
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer()
                    .frame(width: 10)
                ForEach(Icon.allCases, id: \.self) { icon in
                    Button {
                        selectedIcon = icon
                    } label: {
                        PlayerIcon(icon: icon, color: color, weight: .semibold, selected: selectedIcon == icon)
                        .frame(width: 80, height: 80)
                        .padding(.vertical)
                    }
                    .foregroundStyle(color)
                }
                Spacer()
                    .frame(width: 10)
            }
        }
    }
}

#Preview {
    @State var icon: Icon = .backpack
    @State var color: Color = .red
    return IconPicker(selectedIcon: $icon, color: $color)
}
