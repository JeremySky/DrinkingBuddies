//
//  GameView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct GameView: View {
    @State var gamePhase: GamePhase = .guessing
    @State var allHandsAreFlipped: Bool = false
    @State var question: Question? = .one
    @State var cardSelection: CardSelection? = .one
    @State var questionNumber: QuestionNumber = .one
    
    func nextPhase() {
        if !allHandsAreFlipped {
            //MARK: -- Toggle between .guessing and .pointDistribute
            gamePhase = gamePhase == .guessing ? .pointDistribute : .guessing
        }
    }
    func incrementQuestionNumber() {
        switch questionNumber {
        case .one:
            questionNumber = .two
        case .two:
            questionNumber = .three
        case .three:
            questionNumber = .four
        case .four:
            questionNumber = .done
        case .done:
            return
        }
    }
    func nextQuestion() {
        switch questionNumber {
        case .one:
            //SHOULD NOT OCCUR
            return
        case .two:
            question = .two
        case .three:
            question = .three
        case .four:
            //WIP CHANGE PHASE
            question = .four
        case .done:
            question = nil
        }
    }
    func nextCard() {
        switch questionNumber {
        case .one:
            //SHOULD NOT OCCUR
            return
        case .two:
            cardSelection = .two
        case .three:
            cardSelection = .three
        case .four:
            //WIP CHANGE PHASE
            cardSelection = .four
        case .done:
            cardSelection = nil
        }
    }
    
    var body: some View {
        ZStack {
            switch gamePhase {
            case .guessing:
                PlayerHandView(hand: PlayingCard.testHandArray, question: $question, cardSelection: $cardSelection) {
                    nextPhase()
                }
            case .pointDistribute:
                DistributePointsView(points: 4) {
                    nextPhase()
                    incrementQuestionNumber()
                    nextQuestion()
                    nextCard()
                }
            }
        }
    }
    
    enum GamePhase {
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

enum QuestionNumber {
    case one, two, three, four, done
}


enum CardSelection {
    case one, two, three, four
}
