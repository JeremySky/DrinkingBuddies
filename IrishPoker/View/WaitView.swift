//
//  WaitView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct WaitView: View {
    var players: [Player] = [Player.test1, Player.test2, Player.test3, Player.test4]
    @State var selected: Selection?
    var zIndexArr: [Double] {
        switch selected {
        case .one:
            [2, 1, 1, 1]
        case .two:
            [1, 2, 1, 1]
        case .three:
            [1, 1, 2, 1]
        case .four:
            [1, 1, 1, 2]
        case nil:
            [2, 2, 2, 2]
        }
    }
    
    var body: some View {
        ZStack {
            //MARK: -- TITLE
            HStack {
                Image(systemName: "graduationcap")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Jeremy's Turn")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .offset(x: -5)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .zIndex(3)
            
            
            //MARK: -- BODY
            VStack(spacing: 8) {
                Spacer()
                    .frame(height: 70)
                ForEach(players.indices, id: \.self) { i in
                    let player = players[i]
                    PlayerShowHandButton(player: player)
                        .zIndex(zIndexArr[i])
                }
            }
            .padding(.horizontal)
        }
    }
    
    enum Selection {
        case one, two, three, four
    }
}




//MARK: -- PlayerShowHandButton struct
struct PlayerShowHandButton: View {
    let player: Player
    @State var showHand: Bool = false
    
    
    var body: some View {
        //aligned at top for front and back RoundedRectangles
        ZStack(alignment: .top) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: showHand ? 50 : 70)
                    .foregroundStyle(/*showHand ? */player.color /*: player.color.opacity(0.9)*/)
                ZStack {
                    Circle()
                        .stroke(player.color, lineWidth: showHand ? 31 : 0)
                        .fill(Color.white)
                        .frame(width: 50, height: 50)
                    Image(systemName: player.icon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 38, height: 38)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .offset(y: showHand ? -16 : 0)
                Text(player.name)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
            }
            .zIndex(1)
            .onTapGesture {
                showHand.toggle()
            }
            
            
            //MARK: -- PLAYERS' HAND EXTENSION
            if showHand {
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 70 + 80)
                        .foregroundStyle(.white.opacity(0.9))
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 70 + 80)
                        .foregroundStyle(player.color.opacity(0.65))
                        .shadow(radius: 10)
                    HStack {
                        Group {
                            MiniCard(player: player, card: player.hand.one, faceUp: player.hand.one.isFlipped)
                            MiniCard(player: player, card: player.hand.two, faceUp: player.hand.two.isFlipped)
                            MiniCard(player: player, card: player.hand.three, faceUp: player.hand.three.isFlipped)
                            MiniCard(player: player, card: player.hand.four, faceUp: player.hand.four.isFlipped)
                        }
                        .padding(.horizontal, 5)
                    }
                    .padding(.bottom)
                    .padding(.horizontal)
                }
            }
        }
    }
}


//MARK: -- MiniCard Struct
struct MiniCard: View {
    let player: Player
    let card: PlayingCard
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    let durationAndDelay: CGFloat = 0.3
    @State var isFlipped: Bool = false
    
    var faceUp: Bool
    
    
    //MARK: -- FLIP FUNCTION
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
        if !faceUp {
            ZStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 65, height: 70)
                        .foregroundStyle(.white)
                        .shadow(color: player.color == .black ? .white.opacity(0.5) : .black.opacity(0.75), radius: 5)
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
                .rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 0.0, y: 1.0, z: 0.0) )
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 65, height: 70)
                        .foregroundStyle(.white)
                        .shadow(color: player.color == .black ? .white.opacity(0.5) : .black.opacity(0.75), radius: 5)
                    Image("card.back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                }
                .rotation3DEffect(Angle(degrees: backDegree), axis: (x: 0.0, y: 1.0, z: 0.0) )
            }
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 65, height: 70)
                    .foregroundStyle(.white)
                    .shadow(color: player.color == .black ? .white.opacity(0.5) : .black.opacity(0.75), radius: 5)
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








//MARK: -- PREVIEWS
#Preview {
    WaitView()
}
