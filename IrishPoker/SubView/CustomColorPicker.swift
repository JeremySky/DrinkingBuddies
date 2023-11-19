//
//  ColorPicker.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/18/23.
//

import SwiftUI

struct CustomColorPicker: View {
    @Binding var selectedColor: Color
    let colors: [Color] = [.red, .pink, .orange, .yellow, .green, .mint, .teal, .cyan, .blue, .purple, .indigo, .brown, .gray, .black]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .foregroundColor(color)
                        .frame(width: 100, height: 100)
                }
            }
        }
    }
}

#Preview {
    @State var selectedColor: Color = .black
    return CustomColorPicker(selectedColor: $selectedColor)
}
