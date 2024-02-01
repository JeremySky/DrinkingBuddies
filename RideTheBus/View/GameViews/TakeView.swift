//
//  TakeView.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/18/23.
//

import SwiftUI
import Combine

struct TakeView: View {
    @EnvironmentObject var game: GameManager
    @State var pointsToTakeReference: Int
    
    
    var disableNextButton: Bool { countdown != 0 }
    
    
    @State var countdown: Int
    @State var countdownHasStarted: Bool = false
    @State var timerSubscription: Cancellable? = nil
    @State private var timer = Timer.publish(every: 0.3, on: .main, in: .common)
    
    var body: some View {
        ZStack {
            VStack {
                GameHeader(user: game.user, main: { DefaultHeader(user: game.user) })
                Spacer()
                Button {
                    game.takePoints(pointsToTakeReference) { pointsToTake in
                        guard let pointsToTake else { return }
                        pointsToTakeReference = pointsToTake
                        countdown = pointsToTake
                        
                        game.updateStage()
                        
                    }
                } label: {
                    Text("Next")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(disableNextButton ? .gray : game.user.color.value)
                        .cornerRadius(10)
                }
                .padding()
                .padding(.horizontal)
                .disabled(disableNextButton)
            }
            
            Button {
                if !countdownHasStarted {
                    startCountdown()
                }
            } label: {
                VStack(spacing: 0) {
                    Text("\(countdown)")
                        .font(.system(size: 130))
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    if countdown > 0 {
                        Text(countdownHasStarted ? "DRINK!" : "Tap to start")
                            .font(.headline)
                            .foregroundStyle(.gray.opacity(0.4))
                            .offset(y: -10)
                    }
                }
            }
            .disabled(countdownHasStarted)
            
        }
        .onAppear {
                countdownHasStarted = false
                timer = Timer.publish(every: 0.3, on: .main, in: .common)
                countdown = game.lobby.players[game.user.index].pointsToTake
            pointsToTakeReference = game.lobby.players[game.user.index].pointsToTake
        }
        .onReceive(timer) { time in
            if countdown > 0  {
                countdown -= 1
            } else {
                timer.connect().cancel()
            }
        }
    }
    
    
    func startCountdown() {
        countdownHasStarted = true
        timerSubscription = timer.connect()
    }
}

#Preview {
    var points =  GameManager.previewPlayerTakes.game.lobby.players[GameManager.previewPlayerTakes.user.index].pointsToTake
    return TakeView(pointsToTakeReference: points, countdown: points)
        .environmentObject(GameManager.previewPlayerTakes)
}
