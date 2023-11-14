//
//  GameView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct GameView: View {
    @State var gamePhase: Phase = .guessing
    @State var allHandsAreFlipped: Bool = false
    @State var question: Question? = .one
    
    func nextPhase() {
        if !allHandsAreFlipped {
            //MARK: -- Toggle between .guessing and .pointDistribute
            gamePhase = gamePhase == .guessing ? .pointDistribute : .guessing
        }
    }
    
    var body: some View {
        ZStack {
            switch gamePhase {
            case .guessing:
                PlayerHandView(hand: PlayingCard.testHandArray, question: $question, cardSelection: .one) {
                    nextPhase()
                }
            case .pointDistribute:
                DistributePointsView(points: 4) {
                    nextPhase()
                }
            }
        }
    }
    
    enum Phase {
        case guessing
        case pointDistribute
    }
}

#Preview {
    GameView()
}


enum Question: String, RawRepresentable {
    case one = "Guess the Color"
    case two = "Higher or Lower"
    case three = "Inside or Outside"
    case four = "Guess the Suit"
}
