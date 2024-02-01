//
//  CustomButtons.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/10/23.
//

import SwiftUI

struct CustomBackButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                Image(systemName: "chevron.left")
                    .bold()
                Text("Back")
                    .bold()
            }
        })
    }
}

struct AddPlayerButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: "person.badge.plus")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 26, height: 26)
                .fontWeight(.bold)
        })
    }
}
