//
//  WelcomeView.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/12/23.
//

import SwiftUI

struct WelcomeView: View {
    @State var iconIndex = 0
    @State var colorIndex = 0
    
    var body: some View {
        VStack {
            UserIcon(icon: IconSelection.allCases[iconIndex], color: ColorSelection.allCases[colorIndex], size: .large)
            
            Text("Drinking \nBuddies")
                .foregroundStyle(.white)
                .font(.system(size: 75))
                .fontWeight(.black)
                .multilineTextAlignment(.center)
                .shadow(color: .black.opacity(0.25), radius: 10)
            
            Spacer().frame(height: 80)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorSelection.allCases[colorIndex].value)
        .onAppear {
            startTimers()
        }
    }
    
    
    func startTimers() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            withAnimation {
                iconIndex = (iconIndex + 1) % IconSelection.allCases.count
                colorIndex = (colorIndex + 1) % ColorSelection.allCases.count
            }
        }
    }
}

#Preview {
    WelcomeView()
}
