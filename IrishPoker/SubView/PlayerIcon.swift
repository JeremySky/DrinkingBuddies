//
//  PlayerIcon.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/18/23.
//

import SwiftUI

struct PlayerIcon: View {
    var icon: Icon
    var color: Color
    var weight: Font.Weight
    var selected: Bool = false
    var width: CGFloat {
        switch icon {
        case .clipboard:
            75
        case .book:
            67
        case .gradCap:
            60
        case .backpack:
            65
        case .paperclip:
            60
        case .personFrame:
            70
        case .photoFrame:
            60
        case .idCard:
            60
        case .dumbbell:
            60
        case .skateboard:
            60
        }
    }
    var height: CGFloat {
        switch icon {
        case .clipboard:
            70
        case .book:
            70
        case .gradCap:
            75
        case .backpack:
            70
        case .paperclip:
            80
        case .personFrame:
            70
        case .photoFrame:
            70
        case .idCard:
            70
        case .dumbbell:
            63
        case .skateboard:
            80
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.white)
                .shadow(color: selected ? .yellow : .black.opacity(0.25),radius: 10)
            Group {
                Image(systemName: icon.rawValue)
                    .resizable()
                    .foregroundStyle(color)
                Image(systemName: icon.rawValue)
                    .resizable()
                    .foregroundStyle(.black.opacity(0.2))
            }
            .scaledToFill()
            .fontWeight(weight)
            .offset(x: icon == .clipboard ? 3 : 0)
            .padding()
            .frame(width: width, height: height)
        }
        .frame(width: 80)
    }
}

#Preview {
    return ZStack {
        Color.brown
        VStack {
            PlayerIcon(icon: Icon.backpack, color: Color.red, weight: .heavy, selected: false)
            PlayerIcon(icon: Icon.clipboard, color: Color.red, weight: .semibold, selected: true)
        }
    }
}
