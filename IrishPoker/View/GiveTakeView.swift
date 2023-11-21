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
    var body: some View {
        ZStack {
            VStack {
                Group {
                    Text("Choose a card \nto be GIVE")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Text("The other will be TAKE")
                        .font(.headline)
                }
                .multilineTextAlignment(.center)
                
                Group {
                    if game.deck.pile[0].isFlipped {
                        CardFront(card: game.deck.pile[0], dimensions: (260, 390, 13))
                    } else {
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
                    }
                    if game.deck.pile[1].isFlipped {
                        CardFront(card: game.deck.pile[1], dimensions: (260, 390, 13))
                    } else { 
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
                }
                .scaleEffect(0.55)
                .frame(height: 280)
            }
            if bothCardsAreFlipped {
                Button("Next", action: {
                    if player.pointsToGive > 0 {
                        player.stage = .give
                    } else if player.pointsToTake > 0 {
                        player.stage = .take
                    } else {
                        player.stage = .wait
                        game.dequeuePairOfCards()
                        game.updateCurrentPlayer()
                    }
                })
                .buttonStyle(.next)
            }
        }
    }
}

#Preview {
    @State var player = Player.test1
    return GiveTakeView(player: $player)
        .environmentObject(GameViewModel.preview)
}
