//
//  GuessingView.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/14/23.
//

import SwiftUI

struct GuessingView: View {
    @EnvironmentObject var game: GameManager
    @State var selected: String?
    @State var tappable: Bool = false
    @State var disableButtons = false
    
    //MARK: -- check answer & switch stages
    @State var isCorrect: Bool?
    
    
    
    var body: some View {
        ZStack(alignment: .top) {
            //MARK: -- TITLE
            VStack {
                Text(game.question.rawValue)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding()
                
                HStack {
                    //MARK: -- MINI CARDS
                    ForEach(0..<4) { i in
                        if (game.question.number - 1) == i {
                            if let isCorrect {
                                ZStack {
                                    MiniCardHidden()
                                    Image(systemName: isCorrect ? "checkmark" : "xmark")
                                        .resizable()
                                        .scaledToFit()
                                        .bold()
                                        .foregroundStyle(isCorrect ? .green : .red)
                                        .frame(width: 45, height: 45)
                                        .padding(.horizontal, 5)
                                }
                            } else {
                                MiniCardHidden()
                            }
                        } else {
                            if game.lobby.players[game.user.index].hand[i].isFlipped {
                                MiniCardFront(card: game.fetchPlayerCard(at: i))
                            } else {
                                MiniCardBack()
                                    .opacity(0.9)
                            }
                        }
                    }
                }
                .padding(.bottom)
                
                
                //MARK: -- CARD
                BigCard(card: game.fetchPlayerCard(at: game.question.number - 1), tappable: $tappable) {
                    disableButtons = true
                    game.flipCard()
                    checkAnswer()
                }
                .zIndex(1)
                .padding()
                
                
                AnswerButtons(question: game.question, selected: $selected, isDisabled: $disableButtons) {
                    tappable = self.selected == nil ? false : true
                }
                .disabled(disableButtons)
                .padding(.bottom)
                
                
                
            }
            VStack {
                Spacer()
                if let isCorrect {
                    Button {
                        game.setResultsOfGuessing(isCorrect, game.fetchPlayerCard(at: game.question.number - 1).value.rawValue)
                    } label: {
                        Text("Continue")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .background(game.user.color.value)
                            .cornerRadius(10)
                            .padding()
                            .padding(.horizontal)
                    }
                }
            }
        }
    }
    
    
    func checkAnswer() {
        let hand = game.fetchUsersPlayerReference().hand
        let card1 = hand[0]
        let card2 = hand[1]
        let card3 = hand[2]
        let card4 = hand[3]
        var correctAnswer: String
        
        switch game.question {
        case .one:
            correctAnswer = card1.color == .red ? game.question.answers[0] : game.question.answers[1]
            isCorrect = (selected == correctAnswer)
        case .two:
            let cardValue = card2.value.rawValue
            let previousValue = card1.value.rawValue
            if cardValue == previousValue {
                correctAnswer = game.question.answers[2]
                isCorrect = (selected == correctAnswer)
            } else if cardValue > previousValue {
                correctAnswer = game.question.answers[0]
                isCorrect = (selected == correctAnswer)
            } else {
                correctAnswer = game.question.answers[1]
                isCorrect = (selected == correctAnswer)
            }
        case .three:
            let cardValue = card3.value.rawValue
            let previousCardsValues = [card1.value.rawValue, card2.value.rawValue]
            let highValue = previousCardsValues.max()
            let lowValue = previousCardsValues.min()
            
            guard let highValue, let lowValue else { return }
            if cardValue == highValue || cardValue == lowValue {
                correctAnswer = game.question.answers[2]
                isCorrect = (selected == correctAnswer)
            } else if highValue == lowValue {
                correctAnswer = game.question.answers[1]
                isCorrect = (selected == correctAnswer)
            } else if lowValue < cardValue && cardValue < highValue {
                correctAnswer = game.question.answers[0]
                isCorrect = (selected == correctAnswer)
            } else if cardValue < lowValue || cardValue > highValue {
                correctAnswer = game.question.answers[1]
                isCorrect = (selected == correctAnswer)
            }
        case .four:
            correctAnswer = card4.suit.icon
            isCorrect = (selected == correctAnswer)
        }
    }
}

#Preview {
    return GuessingView()
        .environmentObject(GameManager.previewGameStarted)
}
