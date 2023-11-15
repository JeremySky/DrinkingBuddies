//
//  PlayersTurnView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/11/23.
//

import SwiftUI

struct PlayersTurnView: View {
    let player: Player
    var hand: [Card]
    @Binding var question: Question
    @Binding var cardSelection: CardSelection
    
    //MARK: -- use as pointer to persist Card's faceUp property
    var faceUpPropertyArr: [Bool]
    
    var changePhaseAction: (Bool) -> Void
    
    @State var choiceSelection: ChoiceSelection? {
        didSet {
            tappable = self.choiceSelection == nil ? false : true
        }
    }
    
    
    //MARK: -- passed through Card object to make tappable
    @State var tappable: Bool = false
    
    @State var disableButtons = false
    
    
    //MARK: -- check answer
    @State var isCorrect: Bool?
    func checkAnswer() {
        var selectedAnswer: String
        var correctAnswer: String
        
        switch question {
        case .one:
            selectedAnswer = choiceSelection == .one ? "red" : "black"
            correctAnswer = hand[0].color == .red ? "red" : "black"
            isCorrect = selectedAnswer == correctAnswer
        case .two:
            let currentCardValue = hand[1].value.rawValue
            let previousCardValue = hand[0].value.rawValue
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
            let currentCardValue = hand[2].value.rawValue
            let highNum = [hand[0].value.rawValue, hand[1].value.rawValue].max()!
            let lowNum = [hand[0].value.rawValue, hand[1].value.rawValue].min()!
            selectedAnswer = choiceSelection == .one ? "inside" : "outside"
            if hand[2].value.rawValue == hand[0].value.rawValue || hand[2].value.rawValue == hand[1].value.rawValue {
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
            correctAnswer = hand[3].suit.rawValue
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
            VStack {
                Spacer()
                PlayerShowHandButton(player: player, showHand: true)
                    .padding(.horizontal)
                    .disabled(true)
                    .scaleEffect(CGSize(width: 0.8, height: 0.85))
                    .frame(height: 100)
            }
            
            
            //MARK: -- MAIN
            VStack {
                
                
                //MARK: -- TITLE
                Text(question.rawValue)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                
                //MARK: -- CARD
                switch cardSelection {
                case .one:
                    BigCard(card: hand[0], isTappable: $tappable, startFaceUp: false) {
                        disableButtons = true
                        checkAnswer()
                    }
                case .two:
                    BigCard(card: hand[1], isTappable: $tappable, startFaceUp: false) {
                        disableButtons = true
                        checkAnswer()
                    }
                case .three:
                    BigCard(card: hand[2], isTappable: $tappable, startFaceUp: false) {
                        disableButtons = true
                        checkAnswer()
                    }
                case .four:
                    BigCard(card: hand[3], isTappable: $tappable, startFaceUp: false) {
                        disableButtons = true
                        checkAnswer()
                    }
                }
                Spacer()
                    .frame(height: 30)
                
                //MARK: -- BUTTONS
                HStack {
                    switch question {
                    case .one:
                        Button(action: {
                            choiceSelection = choiceSelection == .one ? nil : .one
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
                        .disabled(disableButtons)
                        
                        
                        Button(action: {
                            choiceSelection = choiceSelection == .two ? nil : .two
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
                        .disabled(disableButtons)
                        
                        
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
                        .disabled(disableButtons)
                        
                        
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
                        .disabled(disableButtons)
                        
                        
                    case .three:
                        Button(action: {
                            choiceSelection = choiceSelection == .one ? nil : .one                        }) {
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
                        .disabled(disableButtons)
                        
                        
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
                        .disabled(disableButtons)
                        
                        
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
                        .disabled(disableButtons)
                        
                        
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
                        .disabled(disableButtons)
                        
                        
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
                        .disabled(disableButtons)
                        
                        
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
                        .disabled(disableButtons)
                    case nil:
                        EmptyView()
                    }
                }
                Spacer()
            }
            
            
            //MARK: -- CORRECT OR INCORRECT & CHANGE PHASE
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
                changePhaseAction(isCorrect)
            }
        }
        
        
        
        
        
    }
    enum ChoiceSelection {
        case one, two, three, four
    }
}

#Preview {
    PlayersTurnView(player: Player.test1, hand: [
        Card(value: .ace, suit: .hearts),
        Card(value: .eight, suit: .clubs),
        Card(value: .king, suit: .diamonds),
        Card(value: .ten, suit: .spades)
    ], question: .constant(.one) ,cardSelection: .constant(.one), faceUpPropertyArr: [false, true, false, true], changePhaseAction: {_ in })
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
