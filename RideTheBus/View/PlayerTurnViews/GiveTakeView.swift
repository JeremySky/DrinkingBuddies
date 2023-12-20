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
                
                if secondPick != nil {
                    Button {
                        game.stage = .waiting
                    } label: {
                        Text("Next")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .background(game.user.color.value)
                            .cornerRadius(10)
                    }
                    .padding()
                    .padding(.horizontal)
                }
            }
            .padding()
            
            
            
            GiveTakeCardDisplay(card1: game.deck[0], card2: game.deck[1], firstPick: $firstPick, secondPick: $secondPick)
        }
    }
}


#Preview {
    GiveTakeView()
        .environmentObject(GameManager.previewGameStarted)
}





