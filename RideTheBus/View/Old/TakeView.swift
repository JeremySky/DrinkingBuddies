//
//  TakeView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI
import Combine

struct TakeView: View {
    @EnvironmentObject var game: GameViewModel
    @Binding var player: Player
    @State var countdown: Int
    @State var points: Int
    var endTakeAction: () -> Void
    
    @State var countdownHasStarted: Bool = false
    @State var timerSubscription: Cancellable? = nil
    @State private var timer = Timer.publish(every: 0.3, on: .main, in: .common)
    
    @State var disableButton = false
    
    func startCountdown() {
        disableButton = true
        countdownHasStarted = true
        timerSubscription = timer.connect()
    }
    
    func takeAgain() {
        disableButton = false
        countdownHasStarted = false
        timer = Timer.publish(every: 0.3, on: .main, in: .common)
        countdown = player.pointsToTake
        points = player.pointsToTake
    }
    
    var body: some View {
        ZStack {
            VStack {
                //MARK: -- TITLE
                ZStack {
                    Circle()
                        .fill(.white)
                    Image(systemName: player.icon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .fontWeight(.heavy)
                        .foregroundStyle(player.color)
                        .padding()
                    Image(systemName: player.icon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .fontWeight(.heavy)
                        .foregroundStyle(.black.opacity(0.3))
                        .padding()
                }
                .frame(width: 100, height: 100)
                .padding(.bottom)
                .frame(maxWidth: .infinity)
                .background(player.color)
                
                Spacer()
                Text("\(countdown)")
                    .font(.system(size: 200))
                    .fontWeight(.semibold)
                Spacer()
                
                Button("Start") {
                    if !countdownHasStarted {
                        startCountdown()
                    }
                }
                .buttonStyle(.start)
                .disabled(disableButton)
            }
            
            if countdown == 0 {
                Button("Next") {
                    player.score += points
                    player.pointsToTake -= points
                    if player.pointsToTake == 0 {
                        endTakeAction()
                    } else {
                        takeAgain()
                    }
                }
                .buttonStyle(.next)
            }
        }
        .onReceive(timer) { time in
            if countdown > 0  {
                countdown -= 1
            } else {
                timer.connect().cancel()
            }
        }
    }
}

#Preview {
    @State var player = Player.take
    @State var points = Player.take.pointsToTake
    return TakeView(player: $player, countdown: points, points: points) {}
        .environmentObject(GameViewModel.preview)
}
