//
//  PlayerHeader.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/18/23.
//

import SwiftUI
import Combine

struct PlayerHeader: View {
    @Binding var player: OLDPlayer
    var isForm: Bool = false
    let textLimit = 10
    
    
    var body: some View {
        HStack {
//            UserIcon/*(player: player)*/
//                .frame(width: 80, height: 80)
            
            ZStack {
                if isForm {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white.opacity(0.2))
                        .frame(height: 70)
                        .padding(.trailing, 5)
                    TextField("", text: $player.name)
                        .placeholder(when: player.name.isEmpty) {
                            Text("Name").foregroundStyle(.white.opacity(0.8))
                        }
                        .padding(.horizontal, 16)
                        .onReceive(Just(player.name), perform: { _ in
                            limitText(textLimit)
                        })
                    
                } else {
                    Text(player.name)
                }
            }
            .font(.largeTitle)
            .fontWeight(.heavy)
            .foregroundStyle(.white)
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
    @State var player = OLDPlayer.test1
    return VStack {
        PlayerHeader(player: $player, isForm: true)
        Spacer()
    }
}

//For modifying TextField's default text's color
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
