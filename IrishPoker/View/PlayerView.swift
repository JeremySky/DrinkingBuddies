//
//  GameView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct PlayerView: View {
    let player: Player
    let hand = Card.testHandArray1
    @State var gamePhase: GamePhase = .guessingPhase
    
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
        case .guessingPhase:
            gamePhase = .pointDistributePhase
        case .pointDistributePhase:
            gamePhase = allHandsAreFlipped ? .giveTakePhase : .guessingPhase
        case .giveTakePhase:
            gamePhase = .pointDistributePhase
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
            return
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
            return
        }
    }
    
    var body: some View {
        ZStack {
            switch gamePhase {
            case .guessingPhase:
                PlayersTurnView(hand: hand, question: $question, cardSelection: $cardSelection, faceUpPropertyArr: questionNumber.faceUpPropertyArr) { result in
                    playerGiveOrTake = result ? .give : .take
                    nextPhase()
                }
            case .pointDistributePhase:
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
            case .giveTakePhase:
                GiveTakeView()
            }
        }
    }
    
    enum GamePhase {
        case guessingPhase
        case pointDistributePhase
        case giveTakePhase
    }
}

#Preview {
    PlayerView(player: Player.test1)
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
    case done = 0
    
    var faceUpPropertyArr: [Bool] {
        switch self {
        case .one:
            [false, false, false, false]
        case .two:
            [true, false, false, false]
        case .three:
            [true, true, false, false]
        case .four:
            [true, true, true, false]
        case .done:
            [true, true, true, true]
        }
    }
}

enum GiveOrTake {
    case give, take
}


enum CardSelection {
    case one, two, three, four
}
