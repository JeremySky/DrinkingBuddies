//
//  ColorPicker.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/18/23.
//

import SwiftUI

extension Color {
    static var selection: [Color] = [.red, .pink, .orange, .yellow, .green, .mint, .teal, .cyan, .blue, .purple, .indigo, .brown, .gray, .black]
}

struct CustomColorPicker: View {
    @Binding var selectedColor: Color
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer()
                    .frame(width: 10)
                ForEach(Color.selection, id: \.self) { color in
                    Button {
                        selectedColor = color
                    } label: {
                        Circle()
                            .foregroundStyle(color)
                            .frame(width: selectedColor == color ? 65 : 50, height: 90)
                            .shadow(color: selectedColor == color ? .yellow : .clear, radius: 10)
                    }
                }
                Spacer()
                    .frame(width: 10)
            }
        }
    }
}

#Preview {
    @State var selectedColor: Color = .red
    return VStack {
        CustomColorPicker(selectedColor: $selectedColor)
    }
}
