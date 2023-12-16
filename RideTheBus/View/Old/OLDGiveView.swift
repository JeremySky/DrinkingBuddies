//
//  DistributePointsView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct OLDGiveView: View {
    @Binding var player: OLDPlayer
    @State var points: Int
    @State var temporaryPlayers: [OLDPlayer]
    var giveAction: ([OLDPlayer]) -> Void
    @State var disableButtons: Bool = false
    
    func givePoints(to player: inout OLDPlayer) {
        player.pointsToTake += 1
        
        self.player.pointsToGive -= 1
        points -= 1
    }
    var body: some View {
        ZStack {
            //MARK: -- GIVE
            VStack {
                Spacer()
                Text("\(points)")
                    .font(.system(size: 200))
                    .fontWeight(.semibold)
                Spacer()
                VStack {
                    ForEach(temporaryPlayers.indices, id: \.self) { i in
                        Button {
                            givePoints(to: &temporaryPlayers[i])
                            //track points for PlayerResultsView
                            self.player.giveTo[i] += 1
                        } label: {
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 65, height: 65)
                                        .foregroundStyle(Color.white)
                                        .shadow(radius: 10)
                                    Text("\(temporaryPlayers[i].pointsToTake)")
                                        .font(.largeTitle)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.black)
                                }
                                PlayerLabel(player: temporaryPlayers[i])
                            }
                        }
                        .disabled(disableButtons)
                    }
                    .padding([.horizontal, .bottom])
                }
            }
            
            if points == 0 {
                Button("Next", action: { giveAction(temporaryPlayers) })
                    .buttonStyle(.next)
                    .onAppear {
                        disableButtons = true
                    }
            }
        }
    }
}

#Preview {
    @State var player = OLDPlayer.give
    @State var players = OLDPlayer.testArr
    return OLDGiveView(player: $player, points: player.pointsToGive, temporaryPlayers: players, giveAction: {_ in })
}

extension OLDGiveView {
    init(player: Binding<OLDPlayer>, players: [OLDPlayer], giveAction: @escaping ([OLDPlayer]) -> Void) {
        self.init(player: player, points: player.pointsToGive.wrappedValue, temporaryPlayers: players, giveAction: giveAction)
    }
}
