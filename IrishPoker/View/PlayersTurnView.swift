//
//  PlayersTurnView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/11/23.
//

import SwiftUI

struct PlayersTurnView: View {
    let player: Player
    let card: Card
    let question: Question
    var nextPhaseAction: (Bool) -> Void
    
    @State var choiceSelection: ChoiceSelection?
    
    func updateTappable() {
        tappable = self.choiceSelection == nil ? false : true
//        print("[PlayersTurnView] \(String(describing: choiceSelection))")
    }
    
    //passed through Card object to make tappable
    @State var tappable: Bool = false
    //disabled after flip
    @State var disableButtons = false
    
    
    
    //MARK: -- check answer
    @State var isCorrect: Bool?
    
    func checkAnswer() {
        var selectedAnswer: String
        var correctAnswer: String
        
        switch question {
        case .one:
            selectedAnswer = choiceSelection == .one ? "red" : "black"
            correctAnswer = card.color == .red ? "red" : "black"
            isCorrect = selectedAnswer == correctAnswer
        case .two:
            let currentCardValue = card.value.rawValue
            let previousCardValue = card.value.rawValue
            selectedAnswer = choiceSelection == .one ? "higher" : "lower"
            if currentCardValue == previousCardValue {
                correctAnswer = "same"
            } else if currentCardValue > previousCardValue {
                correctAnswer = "higher"
            } else if currentCardValue < previousCardValue {
                correctAnswer = "lower"
            } else {
                print("ERROR: [PlayerHandView] checkAnswer() case .two")
                return
            }
            isCorrect = selectedAnswer == correctAnswer
        case .three:
            let currentCardValue = card.value.rawValue
            let highNum = [card.value.rawValue, card.value.rawValue].max()!
            let lowNum = [card.value.rawValue, card.value.rawValue].min()!
            selectedAnswer = choiceSelection == .one ? "inside" : "outside"
            if card.value.rawValue == card.value.rawValue || card.value.rawValue == card.value.rawValue {
                correctAnswer = "same"
            } else if currentCardValue > lowNum && currentCardValue < highNum {
                correctAnswer = "inside"
            } else if currentCardValue < lowNum || currentCardValue > highNum {
                correctAnswer = "outside"
            } else {
                print("ERROR: [PlayerHandView] checkAnswer() case .three")
                return
            }
            isCorrect = selectedAnswer == correctAnswer
        case .four:
            switch choiceSelection {
            case .one:
                selectedAnswer = CardSuit.hearts.rawValue
            case .two:
                selectedAnswer = CardSuit.clubs.rawValue
            case .three:
                selectedAnswer = CardSuit.diamonds.rawValue
            case .four:
                selectedAnswer = CardSuit.spades.rawValue
            case nil:
                print("ERROR: [PlayerHandView] checkAnswer() case .four")
                return
            }
            correctAnswer = card.suit.rawValue
            isCorrect = selectedAnswer == correctAnswer
        }
        
        //MARK: -- Use to troubleshoot
        //        print("SELECTED ANSWER: " + selectedAnswer)
        //        print("CORRECT ANSWER: " + correctAnswer)
        //        print("IS CORRECT: \(isCorrect)")
    }
    
    
    
    //MARK: -- BODY
    var body: some View {
        ZStack {
            //MARK: -- HANDQUICKLOOK
            ZStack {
                //show all players with horizontal scrollview
                PlayerShowHandButton(player: player, showHand: true)
                    .padding(.horizontal)
                    .disabled(true)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
            
            
            //MARK: -- MAIN
            //MARK: -- TITLE
            VStack {
                Text(question.rawValue)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                
                //MARK: -- CARD
                BigCard(card: card, isTappable: $tappable, startFaceUp: false) {
                    disableButtons = true
                    checkAnswer()
                }
                
                Spacer()
                    .frame(height: 30)
                
                AnswerButton(question: question, choiceSelection: $choiceSelection, disable: $disableButtons) {
                    updateTappable()
                }
                Spacer()
            }
            
            
            //MARK: -- CORRECT OR INCORRECT & CHANGE PHASE BUTTON
            ZStack {
                if isCorrect != nil {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white)
                        .shadow(radius: 10)
                    HStack {
                        Image(systemName: isCorrect! ? "checkmark" : "xmark")
                            .foregroundStyle(isCorrect! ? .green : .red)
                            .font(.system(size: 60))
                            .fontWeight(.black)
                        Text(isCorrect! ? "CORRECT" : "WRONG")
                            .font(.system(size: 50))
                            .fontWeight(.black)
                            .offset(x: -12)
                    }
                }
            }
            .frame(height: 80)
            .padding()
            .onTapGesture {
                guard let isCorrect else {
                    print("ERROR: [PlayerHandView] isCorrect == nil")
                    return
                }
                nextPhaseAction(isCorrect)
            }
        }
    }
}

#Preview {
    PlayersTurnView(player: Player.test1, card: Card(value: .ace, suit: .hearts), question: .one , nextPhaseAction: {_ in })
}

//#Preview {
//    PlayerHandView(hand: [
//        PlayingCard(value: .ace, suit: .hearts),
//        PlayingCard(value: .eight, suit: .clubs),
//        PlayingCard(value: .king, suit: .diamonds),
//        PlayingCard(value: .ten, suit: .spades)
//    ], question: .constant(.two), cardSelection: .constant(.two), changePhaseAction: {})
//}
//#Preview {
//    PlayerHandView(hand: [
//        PlayingCard(value: .ace, suit: .hearts),
//        PlayingCard(value: .eight, suit: .clubs),
//        PlayingCard(value: .king, suit: .diamonds),
//        PlayingCard(value: .ten, suit: .spades)
//    ], question: .constant(.three), cardSelection: .constant(.three), changePhaseAction: {})
//}
//#Preview {
//    PlayerHandView(hand: [
//        PlayingCard(value: .ace, suit: .hearts),
//        PlayingCard(value: .eight, suit: .clubs),
//        PlayingCard(value: .king, suit: .diamonds),
//        PlayingCard(value: .ten, suit: .spades)
//    ], question: .constant(.four), cardSelection: .constant(.four), changePhaseAction: {})
//}


struct AnswerButton: View {
    let question: Question
    @Binding var choiceSelection: ChoiceSelection?
    @Binding var disable: Bool
    let tapAction: () -> Void
    
    var body: some View {
        //MARK: -- BUTTONS
        HStack {
            switch question {
            case .one:
                Button(action: {
                    choiceSelection = choiceSelection == .one ? nil : .one
//                    print("[AnswerButton] \(String(describing: choiceSelection))")
                    tapAction()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.red)
                            .frame(width: 80, height: 80)
                            .shadow(
                                color: choiceSelection == .one ? .yellow : .gray,
                                radius: 10)
                        Text("Red")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 27))
                            .fontWeight(.bold)
                    }
                }
                .padding(.horizontal, 5)
                .disabled(disable)
                
                
                Button(action: {
                    choiceSelection = choiceSelection == .two ? nil : .two
//                    print("[AnswerButton] \(String(describing: choiceSelection))")
                    tapAction()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.black)
                            .frame(width: 80, height: 80)
                            .shadow(
                                color: choiceSelection == .two ? .yellow : .gray,
                                radius: 10)
                        Text("Black")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 27))
                            .fontWeight(.bold)
                    }
                }
                .padding(.horizontal, 5)
                .disabled(disable)
                
                
            case .two:
                Button(action: {
                    choiceSelection = choiceSelection == .one ? nil : .one
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.white)
                            .frame(width: 80, height: 80)
                            .shadow(
                                color: choiceSelection == .one ? .yellow : .gray,
                                radius: 10)
                        Image(systemName: "arrowshape.up.circle")
                            .resizable()
                            .scaledToFit()
                            .padding(.all, 10)
                            .frame(width: 80, height: 80)
                            .foregroundStyle(Color.black)
                    }
                }
                .padding(.horizontal, 5)
                .disabled(disable)
                
                
                Button(action: {
                    choiceSelection = choiceSelection == .two ? nil : .two
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.white)
                            .frame(width: 80, height: 80)
                            .shadow(
                                color: choiceSelection == .two ? .yellow : .gray,
                                radius: 10)
                        Image(systemName: "arrowshape.down.circle")
                            .resizable()
                            .scaledToFit()
                            .padding(.all, 10)
                            .frame(width: 80, height: 80)
                            .foregroundStyle(Color.black)
                    }
                }
                .padding(.horizontal, 5)
                .disabled(disable)
                
                
            case .three:
                Button(action: {
                    choiceSelection = choiceSelection == .one ? nil : .one
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.white)
                            .frame(width: 80, height: 80)
                            .shadow(
                                color: choiceSelection == .one ? .yellow : .gray,
                                radius: 10)
                        Image(systemName: "arrow.up.right.and.arrow.down.left.circle")
                            .resizable()
                            .scaledToFit()
                            .fontWeight(.medium)
                            .padding(.all, 10)
                            .frame(width: 80, height: 80)
                            .foregroundStyle(Color.black)
                    }
                }
                .padding(.horizontal, 5)
                .disabled(disable)
                
                
                Button(action: {
                    choiceSelection = choiceSelection == .two ? nil : .two
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.white)
                            .frame(width: 80, height: 80)
                            .shadow(
                                color: choiceSelection == .two ? .yellow : .gray,
                                radius: 10)
                        Image(systemName: "arrow.down.left.and.arrow.up.right.circle")
                            .resizable()
                            .scaledToFit()
                            .fontWeight(.medium)
                            .padding(.all, 10)
                            .frame(width: 80, height: 80)
                            .foregroundStyle(Color.black)
                    }
                }
                .padding(.horizontal, 5)
                .disabled(disable)
                
                
            case .four:
                Button(action: {
                    choiceSelection = choiceSelection == .one ? nil : .one
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.white)
                            .frame(width: 80, height: 80)
                            .shadow(
                                color: choiceSelection == .one ? .yellow : .gray,
                                radius: 10)
                        Image(systemName: CardSuit.hearts.icon)
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(Color.red)
                    }
                }
                .padding(.horizontal, 5)
                .disabled(disable)
                
                
                Button(action: {
                    choiceSelection = choiceSelection == .two ? nil : .two
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.white)
                            .frame(width: 80, height: 80)
                            .shadow(
                                color: choiceSelection == .two ? .yellow : .gray,
                                radius: 10)
                        Image(systemName: CardSuit.clubs.icon)
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(Color.black)
                    }
                }
                .padding(.horizontal, 5)
                .disabled(disable)
                
                
                Button(action: {
                    choiceSelection = choiceSelection == .three ? nil : .three
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.white)
                            .frame(width: 80, height: 80)
                            .shadow(
                                color: choiceSelection == .three ? .yellow : .gray,
                                radius: 10)
                        Image(systemName: CardSuit.diamonds.icon)
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(Color.red)
                    }
                }
                .padding(.horizontal, 5)
                .disabled(disable)
                
                
                Button(action: {
                    choiceSelection = choiceSelection == .four ? nil : .four
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.white)
                            .frame(width: 80, height: 80)
                            .shadow(
                                color: choiceSelection == .four ? .yellow : .gray,
                                radius: 10)
                        Image(systemName: CardSuit.spades.icon)
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(Color.black)
                    }
                }
                .padding(.horizontal, 5)
                .disabled(disable)
            }
        }
    }
}



enum ChoiceSelection {
    case one, two, three, four
}
