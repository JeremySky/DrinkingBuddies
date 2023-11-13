//
//  Card.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/11/23.
//

import SwiftUI

struct CardFront: View {
    let card: PlayingCard
    
    var width: CGFloat = 320
    var height: CGFloat = 490
    var fontSize: CGFloat = 70
    var iconSize: CGFloat = 43
    var cornerRadius: CGFloat = 15
    var padding: CGFloat = 16
    
    @Binding var degree: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(Color.white)
                .frame(width: width, height: height)
                .shadow(radius: 10)
            Group {
                ZStack {
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
                        .padding(.leading, padding)
                        
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
                        .padding(.leading, padding)
                        .rotationEffect(.degrees(180))
                    }
                    .frame(width: width, height: height)
                    
                    CardBody(card: card, width: width)
                }
            }
            .foregroundColor(card.color)
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0.0, y: 1.0, z: 0.0) )
    }
}





struct CardBody: View {
    let card: PlayingCard
    var width: CGFloat = 320
    var bodyWidth: CGFloat = 170
    var bodyHeight: CGFloat = 290
    var bodyIconSize: CGFloat = 37
    var bodyBorderWidth: CGFloat = 2
    var bodyCrownSize: CGFloat = 82
    var bodyLargeIconSize: CGFloat = 164
    var bodyLargeLetterSize: CGFloat = 82
    var padding: CGFloat = 16
    
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
        .padding(.all, padding)
        .frame(width: bodyWidth, height: bodyHeight)
        .border(Color.blue, width: bodyBorderWidth)
    }
}




struct CardBack: View {
    var width: CGFloat = 320
    var height: CGFloat = 490
    var cornerRadius: CGFloat = 16
    var bodyWidth: CGFloat = 288
    var bodyHeight: CGFloat = 450
    var bodyCornerRadius: CGFloat = 7
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


struct Card: View {
    let value: PlayingCard
    
    
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    
    
    var width: CGFloat = 320
    var height: CGFloat = 490
    var cornerRadius: CGFloat = 16
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
            CardFront(card: value, width: width, degree: $frontDegree)
            CardBack(width: width, degree: $backDegree)
        }
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.4).ignoresSafeArea()
        Card(value: PlayingCard(value: .ten, suit: .diamonds))
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.4).ignoresSafeArea()
        CardFront(card: PlayingCard(value: .two, suit: .hearts), width: 330, degree: .constant(0))
    }
}

//#Preview {
//    CardBody(card: PlayingCard(value: .nine, suit: .hearts))
//}

#Preview {
    ZStack {
        Color.gray.opacity(0.4).ignoresSafeArea()
        CardBack(width: 330, degree: .constant(0))
    }
}
