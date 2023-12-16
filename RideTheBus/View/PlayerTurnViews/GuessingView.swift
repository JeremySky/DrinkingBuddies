//
//  GuessingView.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/14/23.
//

import SwiftUI

struct GuessingView: View {
    @Binding var player: Player
    @Binding var question: Question
    @State var selected: String?
    @State var tappable: Bool = false
    @State var disableButtons = false
    
    //MARK: -- check answer & switch stages
    @State var isCorrect: Bool?
    var pointsToDistribute: Int { player.hand[question.number - 1].value.rawValue}
    var returnResults: (Bool, Int) -> Void
    
    
    
    var body: some View {
        ZStack {
            //MARK: -- TITLE
            VStack {
                Text(question.rawValue)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                
                //MARK: -- CARD
                BigCard(card: $player.hand[question.number - 1], tappable: $tappable) {
                    disableButtons = true
                    checkAnswer()
                }
                
                Spacer()
                    .frame(height: 30)
                
                AnswerButtons(question: question, selected: $selected) {
                    tappable = self.selected == nil ? false : true
                }
                .disabled(disableButtons)
                
                Spacer()
                
                HStack {
                    //MARK: -- MINI CARDS
                    ForEach(0..<4) { i in
                        if (question.number - 1) == i {
                            MiniCardHidden()
                        } else {
                            if player.hand[i].isFlipped {
                                MiniCardFront(card: player.hand[i])
                            } else {
                                MiniCardBack()
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
            
            
            //MARK: -- CORRECT OR INCORRECT & CHANGE PHASE BUTTON
            if let isCorrect {
                Button(isCorrect ? "Correct" : "Wrong", action: {
                    if isCorrect {
                        player.hand[question.number - 1].giveCards.append(player.hand[question.number - 1])
                    } else {
                        player.hand[question.number - 1].takeCards.append(player.hand[question.number - 1])
                    }
                    returnResults(isCorrect, pointsToDistribute)
                })
                .buttonStyle(isCorrect ? .correct : .wrong)
            }
        }
    }
    
    
    func checkAnswer() {
        let hand = player.hand
        let card1 = hand[0]
        let card2 = hand[1]
        let card3 = hand[2]
        let card4 = hand[3]
        var correctAnswer: String
        
        switch question {
        case .one:
            correctAnswer = card1.color == .red ? question.answers[0] : question.answers[1]
            isCorrect = (selected == correctAnswer)
        case .two:
            let cardValue = card2.value.rawValue
            let previousValue = card1.value.rawValue
            if cardValue == previousValue {
                correctAnswer = question.answers[2]
                isCorrect = (selected == correctAnswer)
            } else if cardValue > previousValue {
                correctAnswer = question.answers[0]
                isCorrect = (selected == correctAnswer)
            } else {
                correctAnswer = question.answers[1]
                isCorrect = (selected == correctAnswer)
            }
        case .three:
            let cardValue = card3.value.rawValue
            let previousCardsValues = [card1.value.rawValue, card2.value.rawValue]
            let highValue = previousCardsValues.max()
            let lowValue = previousCardsValues.min()
            
            guard let highValue, let lowValue else { return }
            if cardValue == highValue || cardValue == lowValue {
                correctAnswer = question.answers[2]
                isCorrect = (selected == correctAnswer)
            } else if highValue == lowValue {
                correctAnswer = question.answers[1]
                isCorrect = (selected == correctAnswer)
            } else if lowValue < cardValue && cardValue < highValue {
                correctAnswer = question.answers[0]
                isCorrect = (selected == correctAnswer)
            } else if cardValue < lowValue || cardValue > highValue {
                correctAnswer = question.answers[1]
                isCorrect = (selected == correctAnswer)
            }
        case .four:
            correctAnswer = card4.suit.icon
            isCorrect = (selected == correctAnswer)
        }
    }
}

#Preview {
    @State var player = Player.previewGameHasStarted[0]
    @State var question = Question.one
    return GuessingView(player: $player, question: $question) { _, _ in }
}
