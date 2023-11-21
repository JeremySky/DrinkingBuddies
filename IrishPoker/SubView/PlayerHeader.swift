//
//  PlayerHeader.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/18/23.
//

import SwiftUI
import Combine

struct PlayerHeader: View {
    @Binding var player: Player
    var isForm: Bool = false
    let textLimit = 10
    var body: some View {
        HStack {
            PlayerIcon(icon: player.icon, color: player.color, weight: .black)
                .frame(width: 80, height: 80)
            
            ZStack {
                if isForm {
                    TextField("", text: $player.name)
                        .placeholder(when: player.name.isEmpty) {
                            Text("Name").foregroundColor(.white)
                        }
                        .padding(.horizontal, isForm ? 8 : 0)
                        .onReceive(Just(player.name), perform: { _ in
                            limitText(textLimit)
                        })
                    
                } else {
                    Text(player.name)
                }
            }
            .font(.largeTitle)
            .fontWeight(.heavy)
            .foregroundStyle(player.color == .white ? .black : .white)
            .frame(height: 100)
        }
        .padding(.horizontal, isForm ? 20 : 0)
        .padding(.bottom, isForm ? 30 : 16)
        .frame(maxWidth: .infinity)
        .background(player.color)
    }
    
    func limitText(_ upper: Int) {
        if player.name.count > upper {
            player.name = String(player.name.prefix(upper))
            }
        }
}

#Preview {
    @State var player = Player.test1
    return PlayerHeader(player: $player)
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
