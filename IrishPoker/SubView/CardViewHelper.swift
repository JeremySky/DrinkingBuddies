//
//  TestCard.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/14/23.
//

import SwiftUI

//MARK: -- GENERIC CARD
//use to apply all flip actions or init face up actions
struct CardViewHelper<Front: View, Back: View>: View {
    let startFaceUp: Bool
    @Binding var isTappable: Bool
    let onTapAction: (() -> Void)?
    let frontView: Front
    let backView: Back
    
    init(startFaceUp: Bool, isTappable: Binding<Bool> = .constant(false), onTapAction: (() -> Void)? = nil, @ViewBuilder frontView: () -> Front, @ViewBuilder backView: () -> Back) {
        self.startFaceUp = startFaceUp
        _isTappable = isTappable
        self.onTapAction = onTapAction
        self.frontView = frontView()
        self.backView = backView()
    }
    
    //MARK: -- FLIP FUNCTION
    //properties used for flip animation
    let durationAndDelay: CGFloat = 0.3
    @State var frontDegree: Double = -90.0
    @State var backDegree: Double = 0.0
    @State var isFlipped: Bool = false
    
    func flipCard() {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90.0
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                frontDegree = 0.0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                backDegree = 0.0
            }
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90.0
            }
        }
    }
    
    var body: some View {
        if !startFaceUp {
            ZStack {
                frontView
                    .rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 0.0, y: 1.0, z: 0.0) )
                backView
                    .rotation3DEffect(Angle(degrees: backDegree), axis: (x: 0.0, y: 1.0, z: 0.0) )
            }
            .onTapGesture {
                if isTappable {
                    flipCard()
                    isTappable = false
                    guard let onTapAction else { return }
                    onTapAction()
                }
            }
        } else {
            frontView
        }
    }
}

#Preview {
    CardViewHelper(startFaceUp: false, isTappable: .constant(true)) {
        RoundedRectangle(cornerRadius: 25.0)
    } backView: {
        RoundedRectangle(cornerRadius: 25.0)
            .foregroundColor(.green)
    }

}
