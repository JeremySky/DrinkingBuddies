//
//  TestCard.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/14/23.
//

import SwiftUI

//MARK: -- GENERIC CARD
//use to apply all flip actions or init face up actions
struct CardViewHelper<Front: View, Back: View>: View {
    let startFaceUp: Bool
    @Binding var isTappable: Bool
    let onTapAction: (() -> Void)?
    let frontView: Front
    let backView: Back
    
    init(startFaceUp: Bool, isTappable: Binding<Bool> = .constant(false), onTapAction: (() -> Void)? = nil, @ViewBuilder frontView: () -> Front, @ViewBuilder backView: () -> Back) {
        self.startFaceUp = startFaceUp
        _isTappable = isTappable
        self.onTapAction = onTapAction
        self.frontView = frontView()
        self.backView = backView()
    }
    
    //MARK: -- FLIP FUNCTION
    //properties used for flip animation
    let durationAndDelay: CGFloat = 0.3
    @State var frontDegree: Double = -90.0
    @State var backDegree: Double = 0.0
    @State var isFlipped: Bool = false
    
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
        if !startFaceUp {
            ZStack {
                frontView
                    .rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 0.0, y: 1.0, z: 0.0) )
                backView
                    .rotation3DEffect(Angle(degrees: backDegree), axis: (x: 0.0, y: 1.0, z: 0.0) )
            }
            .onTapGesture {
                if isTappable {
                    flipCard()
                    isTappable = false
                    guard let onTapAction else { return }
                    onTapAction()
                }
            }
        } else {
            frontView
        }
    }
}


//MARK: -- BIGCARD
struct BigCard: View {
    let card: Card
    @Binding var isTappable: Bool
    let onTapAction: (() -> Void)?
    
    init(card: Card, isTappable: Binding<Bool>, onTapAction: (() -> Void)? = nil) {
        self.card = card
        _isTappable = isTappable
        self.onTapAction = onTapAction
    }
    
    var body: some View {
        CardViewHelper(startFaceUp: false, isTappable: $isTappable, onTapAction: onTapAction) {
            CardFront(card: card)
        } backView: {
            CardBack()
        }
    }
}



//MARK: -- BIGCARD FRONT
struct CardFront: View {
    let card: Card
    
    var width: CGFloat = 300
    var height: CGFloat = 470
    var fontSize: CGFloat = 50
    var iconSize: CGFloat = 45
    var cornerRadius: CGFloat = 15
    var padding: CGFloat = 16
    
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
                    
                    CardBody(card: card)
                }
            }
            .foregroundColor(card.color)
        }
    }
}

struct CardBody: View {
    let card: Card
    var bodyWidth: CGFloat = 150
    var bodyHeight: CGFloat = 290
    var bodyIconSize: CGFloat = 37
    var bodyBorderWidth: CGFloat = 3
    var bodyCrownSize: CGFloat = 82
    var bodyLargeIconSize: CGFloat = 140
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
        .border(Color.blue.opacity(0.3), width: bodyBorderWidth)
    }
}

struct CardBack: View {
    var width: CGFloat = 320
    var height: CGFloat = 470
    var cornerRadius: CGFloat = 16
    var bodyWidth: CGFloat = 275
    var bodyHeight: CGFloat = 425
    var bodyCornerRadius: CGFloat = 10
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(Color.white)
                .frame(width: width, height: height)
                .shadow(radius: 10)
            RoundedRectangle(cornerRadius: bodyCornerRadius)
                .foregroundStyle(Color.red)
                .frame(width: bodyWidth, height: bodyHeight)
            RoundedRectangle(cornerRadius: bodyCornerRadius)
                .foregroundStyle(Color.black.opacity(0.5))
                .frame(width: bodyWidth, height: bodyHeight)
            Image("card.back")
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: bodyCornerRadius - 5))
                .frame(width: bodyWidth * 0.95, height: bodyHeight * 0.96)
        }
    }
}








//MARK: -- MINICARD
struct MiniCard: View {
    let card: Card
    let playerColor: Color
    
    var body: some View {
        CardViewHelper(startFaceUp: false) {
            MiniCardFront(card: card, playerColor: playerColor)
        } backView: {
            MiniCardBack(playerColor: playerColor)
        }
        
        
    }
}

struct MiniCardFront: View {
    let card: Card
    let playerColor: Color
    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 65, height: 70)
                    .foregroundStyle(.white)
                    .shadow(color: playerColor == .black ? .white.opacity(0.5) : .black.opacity(0.75), radius: 5)
                Image(systemName: card.suit.icon)
                    .resizable()
                    .padding(.all, 5)
                    .frame(width: 63, height: 63)
                    .foregroundStyle(card.color)
                Text(card.value.string)
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
            }
        }
    }
}

struct MiniCardBack: View {
    let playerColor: Color
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 65, height: 70)
                .foregroundStyle(.white)
                .shadow(color: playerColor == .black ? .white.opacity(0.5) : .black.opacity(0.75), radius: 5)
            Image("card.back")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 7))
        }
    }
}

#Preview {
    MiniCard(card: Card.test1, playerColor: Player.test1.color)
}
