//
//  AnswerButtons.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/17/23.
//

import SwiftUI

struct AnswerButtons: View {
    let question: Question
    @Binding var selected: String?
    @Binding var isDisabled: Bool
    let tapAction: () -> Void
    
    var body: some View {
        HStack {
            ForEach(question.answers, id: \.self) { answer in
                Button(action: {
                    selected = selected == answer ? nil : answer
                    tapAction()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(question == .one ? (answer == "Red" ? .red : .black) : .white)
                            .frame(width: 80, height: 80)
                            .shadow(
                                color: selected == answer ? .yellow : .gray,
                                radius: 10)
                        if question == .one {
                            Text(answer)
                                .foregroundStyle(Color.white)
                                .font(.system(size: 27))
                                .fontWeight(.bold)
                        } else {
                            Image(systemName: answer)
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle((answer == "suit.heart.fill" || answer == "suit.diamond.fill") ? .red : .black)
                                .padding(.all, 10)
                                .frame(width: 80, height: 80)
                                .foregroundStyle(Color.black)
                        }
                    }
                    .opacity(isDisabled ? (selected == answer ? 0.87 : 0.3) : 1)
                }
                .padding(.horizontal, 5)
            }
        }
    }
}

#Preview {
    @State var selected: String?
    @State var isDisabled: Bool = false
    return AnswerButtons(question: Question.two, selected: $selected, isDisabled: $isDisabled, tapAction: {})
}
