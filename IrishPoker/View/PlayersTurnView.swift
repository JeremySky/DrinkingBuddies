//
//  PlayersTurnView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/11/23.
//

import SwiftUI

struct PlayersTurnView: View {
    //1. Purely for UI setup/changes
    //NEW INSTANCE OF THE PASSED DOWN REFERENCE PLAYER
    @Binding var player: Player
    let question: Question
    var card: Card { player.hand[question.number - 1] }
    var nextPhaseAction: (Bool) -> Void
    
    //1. for updating card tappable property
    //2. for checkAnswer process
    @State var choiceSelection: ChoiceSelection?
    
    func updateTappable() {
        tappable = self.choiceSelection == nil ? false : true
    }
    
    //passed through Card object to make tappable
    @State var tappable: Bool = false
    //disabled after flip
    @State var cardIsFlippable = false
    @State var disableButtons = false
    
    
    //MARK: -- check answer
    @State var result: Bool?
    
    func checkAnswer() {
        var selectedAnswer: String
        var correctAnswer: String
        
        switch question {
        case .one:
            selectedAnswer = choiceSelection == .one ? "red" : "black"
            correctAnswer = card.color == .red ? "red" : "black"
            result = selectedAnswer == correctAnswer
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
            result = selectedAnswer == correctAnswer
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
            result = selectedAnswer == correctAnswer
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
            result = selectedAnswer == correctAnswer
        }
    }
    
    
    
    //MARK: -- BODY
    var body: some View {
        ZStack {
            //MARK: -- TITLE
            VStack {
                Text(question.rawValue)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                
                //MARK: -- CARD
                BigCard(card: $player.hand[question.number - 1], tappable: $tappable) {
                    if tappable {
                        tappable = false
                        checkAnswer()
                        disableButtons = true
                    }
                }
                
                Spacer()
                    .frame(height: 30)
                
                AnswerButton(question: question, choiceSelection: $choiceSelection, disable: $disableButtons) {
                    updateTappable()
                }
                Spacer()
                
                HStack {
                    //MARK: -- MINI CARDS
                    ForEach(0..<4) { i in
                        if (question.number - 1) == i {
                            MiniCardHidden()
                        } else {
                            if player.hand[i].isFlipped {
                                MiniCardFront(card: player.hand[i], playerColor: player.color)
                            } else {
                                MiniCardBack(playerColor: .clear)
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
            
            
            //MARK: -- CORRECT OR INCORRECT & CHANGE PHASE BUTTON
            ZStack {
                if result != nil {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white)
                        .shadow(radius: 10)
                    HStack {
                        Image(systemName: result! ? "checkmark" : "xmark")
                            .foregroundStyle(result! ? .green : .red)
                            .font(.system(size: 60))
                            .fontWeight(.black)
                        Text(result! ? "CORRECT" : "WRONG")
                            .font(.system(size: 50))
                            .fontWeight(.black)
                            .offset(x: -12)
                    }
                }
            }
            .frame(height: 80)
            .padding()
            .onTapGesture {
                guard let result else {
                    print("ERROR: [PlayerHandView] isCorrect == nil")
                    return
                }
                nextPhaseAction(result)
            }
        }
    }
}

#Preview {
    PlayersTurnView(player: .constant(Player.test1), question: .one) { isCorrect in
        if isCorrect {
            print("Correct")
        } else {
            print("WRONG")
        }
    }
    .environmentObject(GameViewModel.preview)
}



struct AnswerButton: View {
    let question: Question
    @Binding var choiceSelection: ChoiceSelection?
    @Binding var disable: Bool
    typealias TapAction = () -> Void
    let completionHandler: TapAction
    
    var body: some View {
        //MARK: -- BUTTONS
        HStack {
            switch question {
            case .one:
                Button(action: {
                    choiceSelection = choiceSelection == .one ? nil : .one
                    //                    print("[AnswerButton] \(String(describing: choiceSelection))")
                    completionHandler()
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
                    completionHandler()
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
