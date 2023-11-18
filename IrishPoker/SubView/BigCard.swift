//
//  BigCard.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/11/23.
//

import SwiftUI


//MARK: -- BIGCARD
struct BigCard: View {
    @Binding var card: Card
    @Binding var tappable: Bool
    let flipCardAction: () -> Void
    
    
    
    //for keeping dimensions standardized
    let dimensions: (width: CGFloat, height: CGFloat, cornerRadius: CGFloat) = (260, 390, 13)
    
    
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
            CardFront(card: card, dimensions: dimensions)
                .rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 0.0, y: 1.0, z: 0.0) )
            CardBack(dimensions: dimensions)
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



//MARK: -- BIGCARD FRONT
struct CardFront: View {
    let card: Card
    let dimensions: (width: CGFloat, height: CGFloat, cornerRadius: CGFloat)
    var fontSize: CGFloat = 50
    var iconSize: CGFloat = 45
    var padding: CGFloat = 3
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: dimensions.cornerRadius)
                .foregroundStyle(Color.white)
                .frame(width: dimensions.width, height: dimensions.height)
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
                        .frame(height: dimensions.height)
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
                        .frame(height: dimensions.height)
                        .padding(.leading, padding)
                        .rotationEffect(.degrees(180))
                    }
                    .frame(width: dimensions.width, height: dimensions.height)
                    
                    CardBody(card: card)
                }
            }
            .foregroundColor(card.color)
        }
    }
}

struct CardBody: View {
    let card: Card
    var dimensions: (width: CGFloat, height: CGFloat, borderWidth: CGFloat) = (150, 290, 3)
    var imageSizes: (small: CGFloat, large: CGFloat, crown: CGFloat, largeLetter: CGFloat) = (37, 140, 82, 82)
    
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
                .font(.system(size: imageSizes.small))
                
                
            case .jack, .queen, .king:
                VStack {
                    Image(systemName: "crown.fill")
                        .font(.system(size: imageSizes.crown))
                    ZStack {
                        Image(systemName: card.suit.icon)
                            .font(.system(size: imageSizes.large))
                        Text(card.value.string)
                            .foregroundStyle(Color.white)
                            .font(.system(size: imageSizes.largeLetter))
                            .fontWeight(.semibold)
                    }
                }
                
            case .ace:
                ZStack {
                    Image(systemName: card.suit.icon)
                        .font(.system(size: imageSizes.large))
                    Text(card.value.string)
                        .foregroundStyle(Color.white)
                        .font(.system(size: imageSizes.largeLetter))
                        .fontWeight(.semibold)
                }
            }
        }
        .foregroundColor(card.color)
        .padding(.all, 16)
        .frame(width: dimensions.width, height: dimensions.height)
        .border(Color.blue.opacity(0.3), width: dimensions.borderWidth)
    }
}

struct CardBack: View {
    let dimensions: (width: CGFloat, height: CGFloat, cornerRadius: CGFloat)
    let innerDimensions: (width: CGFloat, height: CGFloat, cornerRadius: CGFloat) = (235, 365, 5)
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: dimensions.cornerRadius)
                .foregroundStyle(Color.white)
                .frame(width: dimensions.width, height: dimensions.height)
                .shadow(radius: 10)
            RoundedRectangle(cornerRadius: innerDimensions.cornerRadius)
                .foregroundStyle(Color.red)
                .frame(width: innerDimensions.width, height: innerDimensions.height)
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(Color.black.opacity(0.5))
                .frame(width: innerDimensions.width, height: innerDimensions.height)
            Image("card.back")
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: innerDimensions.cornerRadius - 3))
                .frame(width: (innerDimensions.width - 15), height: (innerDimensions.height - 15))
        }
    }
}
//
//#Preview {
//    return BigCard(card: Card(value: .ace, suit: .spades), isTappable: .constant(true), startFaceUp: true)
//}
//#Preview {
//    return BigCard(card: Card(value: .two, suit: .spades), isTappable: .constant(true), startFaceUp: true)
//}
//#Preview {
//    return BigCard(card: Card(value: .seven, suit: .spades), isTappable: .constant(true), startFaceUp: true)
//}
//#Preview {
//    return BigCard(card: Card(value: .ten, suit: .spades), isTappable: .constant(true), startFaceUp: true)
//}
#Preview {
    return BigCard(card: .constant(Card(value: .jack, suit: .spades)), tappable: .constant(true), flipCardAction: { })
}
//#Preview {
//    return BigCard(card: Card(value: .queen, suit: .spades), isTappable: .constant(true), startFaceUp: true)
//}
//#Preview {
//    return BigCard(card: Card(value: .king, suit: .spades), isTappable: .constant(true), startFaceUp: true)
//}
//#Preview {
//    return BigCard(card: Card.test1, isTappable: .constant(true), startFaceUp: false)
//}
