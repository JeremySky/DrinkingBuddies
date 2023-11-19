//
//  CreatePlayerForm.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/18/23.
//

import SwiftUI

struct CreatePlayerForm: View {
    @State var player = Player()
    var body: some View {
        VStack{
            PlayerHeader(player: $player, isForm: true)
            Spacer()
            CustomColorPicker(selectedColor: $player.color)
            IconPicker(selectedIcon: $player.icon, color: $player.color)
            Spacer()
            
            Button {
                //
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white)
                        .shadow(radius: 10)
                    HStack {
                        Spacer()
                            .frame(width: 15)
                        Text("NEXT")
                            .font(.system(size: 50))
                            .fontWeight(.black)
                        Image(systemName: "arrow.right")
                            .foregroundStyle(.blue)
                            .font(.system(size: 60))
                            .fontWeight(.black)
                    }
                }
                .frame(height: 80)
                .foregroundStyle(Color.primary)
                .padding()
            }
        }
    }
}

#Preview {
    CreatePlayerForm()
}

