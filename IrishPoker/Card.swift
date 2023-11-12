//
//  Card.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/11/23.
//

import SwiftUI

struct PlayingCard: Identifiable {
    var id: String { "\(value.string).\(suit.rawValue)" }
    var value: CardValue
    var suit: CardSuit
    var color: Color {
        switch self.suit {
        case .clubs, .spades:
            Color.black
        case .hearts, .diamonds:
            Color.red
        }
    }
    var isCentered: Bool {
        if self.value == .seven || self.value == .eight || self.value == .ten {
            false
        } else {
            true
        }
    }
}

enum CardValue: Int {
    case two = 2
    case three = 3
    case four  = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    case jack = 11
    case queen = 12
    case king = 13
    case ace = 14
    
    var string: String {
        switch self {
        case .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten:
            String(self.rawValue)
        case .jack:
            "J"
        case .queen:
            "Q"
        case .king:
            "K"
        case .ace:
            "A"
        }
    }
}

enum CardSuit: String {
    case clubs
    case spades
    case hearts
    case diamonds
    
    var icon: String {
        switch self {
        case .clubs:
            "suit.club.fill"
        case .spades:
            "suit.spade.fill"
        case .hearts:
            "suit.heart.fill"
        case .diamonds:
            "suit.diamond.fill"
        }
    }
}


struct Card: View {
    let card: PlayingCard
    
    var width: Double =  330
    var height: Double { width * 1.530}
    var fontSize: Double { width * 0.1741}
    var iconSize: Double { width * 0.1228 }
    var cornerRadius: Double { width * 0.0513 }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(Color.white)
                .frame(width: width, height: height)
            Group {
                HStack {
                    VStack {
                        Text(card.value.string)
                            .font(.system(size: fontSize))
                            .fontWeight(.semibold)
                        Image(systemName: card.suit.icon)
                            .font(.system(size: iconSize))
                        Spacer()
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    CardBody(card: card, width: width)
                    
                    Spacer()
                    
                    VStack {
                        Text(card.value.string)
                            .font(.system(size: fontSize))
                            .fontWeight(.semibold)
                        Image(systemName: card.suit.icon)
                            .font(.system(size: iconSize))
                        Spacer()
                    }
                    .padding(.leading)
                    .rotationEffect(.degrees(180))
                }
            }
            .padding()
            .foregroundColor(card.color)
        }
        .frame(width: width, height: height)
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.4).ignoresSafeArea()
        Card(card: PlayingCard(value: .eight, suit: .spades))
            .padding()
    }
}




struct CardBody: View {
    let card: PlayingCard
    var width: Double
    var bodyWidth: Double { width * 0.5341 }
    var bodyHeight: Double { width * 0.9087 }
    var bodyIconSize: Double { width * 0.1182 }
    var bodyBorderWidth: Double { width * 0.0077 }
    var bodyCrownSize: Double { width * 0.3589 }
    var bodyLargeIconSize: Double { width * 0.5128 }
    var bodyLargeLetterSize: Double { width * 0.2564 }
    
    var body: some View {
        Group {
            switch card.value {
            case .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten:
                HStack {
                    if card.value != .two && card.value != .three {
                        VStack {
                            Image(systemName: card.suit.icon)
                            Spacer()
                            Image(systemName: card.suit.icon)
                                .foregroundColor(card.value == .four || card.value == .five ? Color.clear : card.color)
                            Spacer()
                            Image(systemName: card.suit.icon)
                            if card.value == .nine || card.value == .ten {
                                Spacer()
                                Image(systemName: card.suit.icon)
                            }
                        }
                    }
                    Spacer()
                    
                    if card.value != .four && card.value != .six {
                        if card.isCentered {
                            VStack {
                                Image(systemName: card.suit.icon)
                                    .foregroundColor(card.value == .five || card.value == .nine ? Color.clear : card.color)
                                Spacer()
                                Image(systemName: card.suit.icon)
                                    .foregroundColor(card.value == .two ? Color.clear : card.color)
                                Spacer()
                                Image(systemName: card.suit.icon)
                                    .foregroundColor(card.value == .five || card.value == .nine ? Color.clear : card.color)
                            }
                        } else {
                            VStack {
                                Spacer()
                                Image(systemName: card.suit.icon)
                                Spacer()
                                Image(systemName: card.suit.icon)
                                    .foregroundStyle(card.value == .seven ? Color.clear : card.color)
                                Spacer()
                            }
                        }
                    }
                    
                    
                    Spacer()
                    if card.value != .two && card.value != .three {
                        VStack {
                            Image(systemName: card.suit.icon)
                            Spacer()
                            Image(systemName: card.suit.icon)
                                .foregroundColor(card.value == .four || card.value == .five ? Color.clear : card.color)
                            Spacer()
                            Image(systemName: card.suit.icon)
                            if card.value == .nine || card.value == .ten {
                                Spacer()
                                Image(systemName: card.suit.icon)
                            }
                        }
                    }
                }
                .font(.system(size: bodyIconSize))
                
                
            case .jack, .queen, .king:
                VStack {
                    Image(systemName: "crown.fill")
                        .font(.system(size: bodyCrownSize))
                    ZStack {
                        Image(systemName: card.suit.icon)
                            .font(.system(size: bodyLargeIconSize))
                        Text(card.value.string)
                            .foregroundStyle(Color.white)
                            .font(.system(size: bodyLargeLetterSize))
                            .fontWeight(.semibold)
                    }
                }
                
            case .ace:
                ZStack {
                    Image(systemName: card.suit.icon)
                        .font(.system(size: bodyLargeIconSize))
                    Text(card.value.string)
                        .foregroundStyle(Color.white)
                        .font(.system(size: bodyLargeLetterSize))
                        .fontWeight(.semibold)
                }
            }
        }
        .foregroundColor(card.color)
        .padding()
        .frame(width: bodyWidth, height: bodyHeight)
        .border(Color.blue, width: bodyBorderWidth)
    }
}


//#Preview {
//    CardBody(card: PlayingCard(value: .nine, suit: .hearts))
//}
