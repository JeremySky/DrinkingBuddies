//
//  Card.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/11/23.
//

import SwiftUI

struct CardFront: View {
    let card: PlayingCard
    
    var width: CGFloat =  330
    var height: CGFloat { width * 1.530}
    var fontSize: CGFloat { width * 0.1741}
    var iconSize: CGFloat { width * 0.1228 }
    var cornerRadius: CGFloat { width * 0.0513 }
    
    @Binding var degree: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(Color.white)
                .frame(width: width, height: height)
                .shadow(radius: 10)
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
                    .frame(height: height)
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
                    .frame(height: height)
                    .padding(.leading)
                    .rotationEffect(.degrees(180))
                }
                .frame(width: width, height: height)
            }
            .foregroundColor(card.color)
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0.0, y: 1.0, z: 0.0) )
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.4).ignoresSafeArea()
        CardFront(card: PlayingCard(value: .two, suit: .spades), degree: .constant(0))
    }
}




struct CardBody: View {
    let card: PlayingCard
    var width: CGFloat
    var bodyWidth: CGFloat { width * 0.5341 }
    var bodyHeight: CGFloat { width * 0.9087 }
    var bodyIconSize: CGFloat { width * 0.1182 }
    var bodyBorderWidth: CGFloat { width * 0.0077 }
    var bodyCrownSize: CGFloat { width * 0.2589 }
    var bodyLargeIconSize: CGFloat { width * 0.5128 }
    var bodyLargeLetterSize: CGFloat { width * 0.2564 }
    
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


struct CardBack: View {
    var width: CGFloat = 330
    var height: CGFloat { width * 1.530}
    var cornerRadius: CGFloat { width * 0.0513 }
    var bodyWidth: CGFloat { width * 0.9000}
    var bodyHeight: CGFloat { height * 0.8800 }
    var bodyCornerRadius: CGFloat { width * 0.0213 }
    
    @Binding var degree: Double
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(Color.white)
                .frame(width: width, height: height)
                .shadow(radius: 10)
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(Color.red)
                .frame(width: bodyWidth, height: bodyHeight)
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(Color.black.opacity(0.5))
                .frame(width: bodyWidth, height: bodyHeight)
            Image("card.back")
                .resizable()
//                .opacity(0.8)
                .clipShape(RoundedRectangle(cornerRadius: bodyCornerRadius))
                .frame(width: bodyWidth * 0.97, height: bodyHeight * 0.97)
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0.0, y: 1.0, z: 0.0) )
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.4).ignoresSafeArea()
        CardBack(degree: .constant(0))
    }
}

struct Card: View {
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    
    var width: CGFloat = 330
    var height: CGFloat { width * 1.530}
    var cornerRadius: CGFloat { width * 0.0513 }
    let durationAndDelay: CGFloat = 0.3
    
    func flipCard() {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90.0
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                frontDegree = 0.0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                backDegree = 0.0
            }
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90.0
            }
        }
    }
    var body: some View {
        ZStack {
            CardFront(card: PlayingCard(value: .ace, suit: .hearts), degree: $frontDegree)
            CardBack(degree: $backDegree)
        }
        .onTapGesture {
            flipCard()
        }
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.4).ignoresSafeArea()
        Card()
    }
}
