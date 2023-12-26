//
//  GiveTakeView.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/14/23.
//

import SwiftUI

struct GiveTakeView: View {
    @EnvironmentObject var game: GameManager
    @State var firstPick: CardValue?
    @State var secondPick: CardValue?
    
    
    var body: some View {
        ZStack {
            
            VStack {
                Group {
                    if firstPick == nil {
                        Text("Choose a card \nto be GIVE")
                        Text("The other will be TAKE")
                            .font(.headline)
                            .foregroundStyle(.gray)
                    } else {
                        Text("FLIP the \nremaining Card")
                        Text("to continue")
                            .font(.headline)
                            .foregroundStyle(.gray)
                    }
                }
                .font(.title)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                
                Spacer()
                
                Button {
                    //WIP START HERE
                    game.updateStage()
                    game.turnCompleted()
                } label: {
                    Text("Next")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(secondPick == nil ? .gray : game.user.color.value)
                        .cornerRadius(10)
                }
                .padding()
                .padding(.horizontal)
                .disabled(secondPick == nil)
            }
            .padding()
            
            
            
            GiveTakeCardDisplay(card1: game.deck.pile[game.deck.pile.count - 1], card2: game.deck.pile[game.deck.pile.count - 2], firstPick: $firstPick, secondPick: $secondPick)
        }
    }
}


#Preview {
    GiveTakeView()
        .environmentObject(GameManager.previewGameStarted)
}





