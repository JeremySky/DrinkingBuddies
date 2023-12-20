//
//  PlayerIcon.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/18/23.
//

import SwiftUI

struct UserIcon: View {
    var icon: IconSelection
    var color: ColorSelection
    var size: IconSize
    var isSelected: Bool = false
    var weight: Font.Weight {
        switch self.size {
        case .large:
                .heavy
        case .medium:
                .bold
        case .small:
                .semibold
        }
    }
    var frameSize: CGFloat {
        switch self.size {
        case .large:
            77
        case .medium:
            58
        case .small:
            50
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.white)
                .shadow(color: isSelected ? .yellow : .black.opacity(0.25),radius: 10)
            Group {
                Image(systemName: icon.rawValue)
                    .resizable()
                    .foregroundStyle(color.value)
                Image(systemName: icon.rawValue)
                    .resizable()
                    .foregroundStyle(.black.opacity(0.2))
            }
            .scaledToFit()
            .fontWeight(weight)
            .offset(x: icon == .clipboard ? 3 : 0)
            .padding(.all, self.size == .large ? 11 : 7)
        }
        .frame(width: frameSize, height: frameSize)
    }
}

extension UserIcon {
    init(icon: IconSelection, color: ColorSelection, selected: Bool) {
        self.init(icon: icon, color: color, size: .large, isSelected: selected)
    }
    
    init(user: User, size: IconSize = .large) {
        self.init(icon: user.icon, color: user.color, size: size, isSelected: false)
    }
}


//#Preview {
//    return ZStack {
//        Color.brown
//        VStack {
//            PlayerIcon(icon: IconSelection.drink, color: Color.red, weight: .heavy, isSelected: false)
//            PlayerIcon(icon: IconSelection.clipboard, color: Color.red, weight: .semibold, isSelected: true)
//        }
//    }
//}

enum IconSelection: String, RawRepresentable, CaseIterable, Codable {
    case drink = "mug"
    case clipboard = "pencil.and.list.clipboard"
    case book = "text.book.closed"
    case gradCap = "graduationcap"
    case backpack = "backpack"
    case paperclip = "paperclip"
    case personFrame = "person.crop.artframe"
    case photoFrame = "photo.artframe"
    case idCard = "person.text.rectangle"
    case dumbbell = "dumbbell.fill"
    case skateboard = "skateboard"
    
}

enum IconSize {
    case small, medium, large
}


#Preview {
    @State var player = Player.previewGameHasStarted[0]
    return ZStack {
        NewGameView(joinedGame: .constant(true))
            .environmentObject(GameManager.previewSetUp)
        PlayerOverView(player: $player)
            .padding()
    }
}
