//
//  GameView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct GameView: View {
    let player: Player
    let hand = PlayingCard.testHandArray
    @State var gamePhase: GamePhase = .guessing
    
    @State var playerGiveOrTake: GiveOrTake = .give
    var pointsToPass: Int {
        let i = questionNumber.rawValue - 1
        return hand[i].value.rawValue
    }
    
    //Parameter to change from guessing phase to give/take phase
    @State var allHandsAreFlipped: Bool = false
    
    //Three different pointers because data will be updating at different times
    @State var questionNumber: QuestionNumber = .one
    @State var question: Question? = .one
    @State var cardSelection: CardSelection? = .one
    
    
    //manages all phase changes
    func nextPhase() {
        switch gamePhase {
        case .guessing:
            gamePhase = .pointDistribute
        case .pointDistribute:
            gamePhase = allHandsAreFlipped ? .giveTake : .guessing
        case .giveTake:
            gamePhase = .pointDistribute
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
            allHandsAreFlipped = true
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
        }
    }
    
    var body: some View {
        ZStack {
            switch gamePhase {
            case .guessing:
                PlayerHandView(hand: hand, question: $question, cardSelection: $cardSelection) { result in
                    playerGiveOrTake = result ? .give : .take
                    nextPhase()
                }
            case .pointDistribute:
                switch playerGiveOrTake {
                case .give:
                    GiveView(points: pointsToPass) {
                        incrementQuestionNumber()
                        nextQuestion()
                        nextCard()
                        nextPhase()
                    }
                case .take:
                    TakeView(points: pointsToPass, player: player) {
                        incrementQuestionNumber()
                        nextQuestion()
                        nextCard()
                        nextPhase()
                    }
                }
            case .giveTake:
                Text("GIVE TAKE")
            }
        }
    }
    
    enum GamePhase {
        case guessing
        case pointDistribute
        case giveTake
    }
}

#Preview {
    GameView(player: Player.test1)
}


enum Question: String, RawRepresentable {
    case one = "Guess the Color"
    case two = "Higher or Lower"
    case three = "Inside or Outside"
    case four = "Guess the Suit"
}

enum QuestionNumber: Int {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
}

enum GiveOrTake {
    case give, take
}


enum CardSelection {
    case one, two, three, four
}
