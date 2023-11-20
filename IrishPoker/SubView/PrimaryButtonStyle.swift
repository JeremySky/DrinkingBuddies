//
//  NextButton.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/19/23.
//

import SwiftUI

struct NextButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .shadow(radius: 10)
            HStack {
                Spacer()
                    .frame(width: 15)
                Text("NEXT")
                    .font(.system(size: 50))
                    .fontWeight(.black)
                Image(systemName: "arrow.right")
                    .foregroundStyle(.blue)
                    .font(.system(size: 60))
                    .fontWeight(.black)
            }
        }
        .frame(height: 80)
        .foregroundStyle(Color.primary)
    }
}

#Preview {
    NextButton()
}
