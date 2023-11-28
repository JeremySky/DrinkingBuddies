//
//  GiveTakeView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct GiveTakeView: View {
    @EnvironmentObject var game: GameViewModel
    @Binding var player: Player
    @State var firstPick: CardValue?
    @State var secondPick: CardValue?
    var bothCardsAreFlipped: Bool {
        game.deck.pile[0].isFlipped == true && game.deck.pile[1].isFlipped == true
    }
    var giveTakeAction: () -> Void
    
    
    var body: some View {
        ZStack {
            VStack {
                PlayerHeader(player: $player)
                
                Group {
                    Text("Choose a card \nto be GIVE")
                        .font(.title)
                        .fontWeight(.heavy)
                    Text("The other will be TAKE")
                        .font(.headline)
                        .foregroundStyle(.gray)
                }
                .multilineTextAlignment(.center)
                
                Group {
                    BigCard(card: $game.deck.pile[0], tappable: .constant(true)) {
                        let card1 = game.deck.pile[0]
                        if firstPick == nil {
                            game.checkForGive(card1)
                            firstPick = card1.value
                        } else {
                            game.checkForTake(card1)
                            secondPick = card1.value
                            print(firstPick!.rawValue)
                            print(secondPick!.rawValue)
                        }
                    }
                    BigCard(card: $game.deck.pile[1], tappable: .constant(true)) {
                        let card2 = game.deck.pile[1]
                        if firstPick == nil {
                            game.checkForGive(card2)
                            firstPick = card2.value
                        } else {
                            game.checkForTake(card2)
                            secondPick = card2.value
                            print(firstPick!.rawValue)
                            print(secondPick!.rawValue)
                        }
                    }
                }
                .scaleEffect(0.55)
                .frame(height: 220)
                
                Spacer()
            }
            if bothCardsAreFlipped {
                Button("Next", action: {
                    giveTakeAction()
                })
                .buttonStyle(.next)
            }
        }
    }
}

#Preview {
    @State var player = Player.test1
    return GiveTakeView(player: $player) {}
        .environmentObject(GameViewModel.preview)
}
