//
//  BigCard.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/11/23.
//

import SwiftUI

extension Card {
    static var dimensions: (width: CGFloat, height: CGFloat, cornerRadius: CGFloat) = (250, 370, 7)
    static var bodyDimensions: (width: CGFloat, height: CGFloat, borderWidth: CGFloat) = (148, 270, 3)
    static var innerDimensions: (width: CGFloat, height: CGFloat, cornerRadius: CGFloat) = (230, 340, 5)
    static var fontSize: CGFloat = 38
    static var iconSize: CGFloat = 36
    static var padding: CGFloat = 7
    static var imageSizes: (small: CGFloat, large: CGFloat, crown: CGFloat, largeLetter: CGFloat) = (32, 120, 82, 70)
}

//MARK: -- BIGCARD
struct BigCard: View {
    @State var card: Card
    @Binding var tappable: Bool
    let flipCardAction: () -> Void
    
    
    //MARK: -- FLIP FUNCTION
    //properties used for flip animation
    let durationAndDelay: CGFloat = 0.3
    @State var frontDegree: Double = -90.0
    @State var backDegree: Double = 0.0
    @State var cardWasAnimated: Bool = false
    func flipCard() {
        withAnimation(.linear(duration: durationAndDelay)) {
            backDegree = 90.0
        }
        withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
            frontDegree = 0.0
        }
    }
    
    
    var body: some View {
        ZStack {
            CardFront(card: card)
                .rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 0.0, y: 1.0, z: 0.0) )
            CardBack()
                .rotation3DEffect(Angle(degrees: backDegree), axis: (x: 0.0, y: 1.0, z: 0.0) )
        }
        .onTapGesture {
            if tappable {
                tappable = false
                if !card.isFlipped {
                    card.isFlipped = true
                    flipCard()
                    flipCardAction()
                }
            }
        }
    }
}


struct WelcomeCard: View {
    @State var tappable: Bool = true
    let flipCardAction: () -> Void
    
    //MARK: -- FLIP FUNCTION
    //properties used for flip animation
    let durationAndDelay: CGFloat = 0.3
    @State var frontDegree: Double = -90.0
    @State var backDegree: Double = 0.0
    func flipCard() {
        withAnimation(.linear(duration: durationAndDelay)) {
            backDegree = 90.0
        }
        withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
            frontDegree = 0.0
        }
    }
    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: Card.dimensions.cornerRadius)
                    .foregroundStyle(Color.white)
                    .frame(width: Card.dimensions.width, height: Card.dimensions.height)
                    .shadow(radius: 10)
                Group {
                    ZStack {
                        Text("Welcome")
                    }
                }
            }
            .rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 0.0, y: 1.0, z: 0.0) )
            
            CardBack()
                .rotation3DEffect(Angle(degrees: backDegree), axis: (x: 0.0, y: 1.0, z: 0.0) )
        }
        .onTapGesture {
            flipCard()
            flipCardAction()
        }
    }
}


//MARK: -- BIGCARD FRONT
struct CardFront: View {
    let card: Card
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Card.dimensions.cornerRadius)
                .foregroundStyle(Color.white)
                .frame(width: Card.dimensions.width, height: Card.dimensions.height)
                .shadow(radius: 10)
            Group {
                ZStack {
                    HStack { //CORNER NUMBERS & SUIT
                        VStack {
                            Text(card.value.string)
                                .font(.system(size: Card.fontSize))
                                .fontWeight(.semibold)
                            Image(systemName: card.suit.icon)
                                .font(.system(size: Card.iconSize))
                            Spacer()
                        }
                        .frame(height: Card.dimensions.height)
                        .padding(.leading, Card.padding)
                        
                        Spacer()
                        
                        VStack {
                            Text(card.value.string)
                                .font(.system(size: Card.fontSize))
                                .fontWeight(.semibold)
                            Image(systemName: card.suit.icon)
                                .font(.system(size: Card.iconSize))
                            Spacer()
                        }
                        .frame(height: Card.dimensions.height)
                        .padding(.leading, Card.padding)
                        .rotationEffect(.degrees(180))
                    }
                    .frame(width: Card.dimensions.width, height: Card.dimensions.height)
                    
                    CardBody(card: card)
                }
            }
            .foregroundColor(card.color)
        }
    }
}

struct CardBody: View {
    let card: Card
    
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
                .font(.system(size: Card.imageSizes.small))
                
                
            case .jack, .queen, .king:
                VStack {
                    Image(systemName: "crown.fill")
                        .font(.system(size: Card.imageSizes.crown))
                    ZStack {
                        Image(systemName: card.suit.icon)
                            .font(.system(size: Card.imageSizes.large))
                        Text(card.value.string)
                            .foregroundStyle(Color.white)
                            .font(.system(size: Card.imageSizes.largeLetter))
                            .fontWeight(.semibold)
                    }
                }
                
            case .ace:
                ZStack {
                    Image(systemName: card.suit.icon)
                        .font(.system(size: Card.imageSizes.large))
                    Text(card.value.string)
                        .foregroundStyle(Color.white)
                        .font(.system(size: Card.imageSizes.largeLetter))
                        .fontWeight(.semibold)
                }
            }
        }
        .foregroundColor(card.color)
        .padding(.all, 16)
        .frame(width: Card.bodyDimensions.width, height: Card.bodyDimensions.height)
        .border(Color.blue.opacity(0.3), width: Card.bodyDimensions.borderWidth)
    }
}

struct CardBack: View {
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Card.dimensions.cornerRadius)
                .foregroundStyle(Color.white)
                .frame(width: Card.dimensions.width, height: Card.dimensions.height)
                .shadow(radius: 10)
            RoundedRectangle(cornerRadius: Card.innerDimensions.cornerRadius)
                .foregroundStyle(Color.red)
                .frame(width: Card.innerDimensions.width, height: Card.innerDimensions.height)
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(Color.black.opacity(0.5))
                .frame(width: Card.innerDimensions.width, height: Card.innerDimensions.height)
            Image("card.back")
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: Card.innerDimensions.cornerRadius))
                .frame(width: (Card.innerDimensions.width - 15), height: (Card.innerDimensions.height - 15))
        }
    }
}

#Preview {
    BigCard(card: Card.test1, tappable: .constant(true)) {}
}
