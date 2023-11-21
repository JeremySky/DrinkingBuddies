//
//  WaitView.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/13/23.
//

import SwiftUI

struct WaitView: View {
    @EnvironmentObject var game: GameViewModel
    @Binding var player: Player
    @State var selected: Selection?
    
    var body: some View {
        VStack {
            //MARK: -- TITLE
            HStack {
                ZStack {
                    Circle()
                        .fill(.white)
                    Image(systemName: game.currentPlayer.icon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .fontWeight(.heavy)
                        .foregroundStyle(game.currentPlayer.color)
                        .padding()
                    Image(systemName: game.currentPlayer.icon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .fontWeight(.heavy)
                        .foregroundStyle(.black.opacity(0.3))
                        .padding()
                }
                .frame(width: 100, height: 100)
                Text("\(game.currentPlayer.name)'s Turn")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
            }
            .padding(.bottom)
            .frame(maxWidth: .infinity)
            .background(game.currentPlayer.color)
            
            
            //MARK: -- BODY
            ScrollView {
                Spacer()
                    .frame(height: 10)
                ForEach($game.players.indices, id: \.self) { i in
                    PlayerOverview(player: $game.players[i], highlightPlayer: true)
                        .padding(.horizontal)
                }
            }
        }
        .onAppear {
            if player.id == game.currentPlayer.id {
                player.stage = .guess
            }
        }
    }
    enum Selection {
        case one, two, three, four
    }
}










//MARK: -- PREVIEWS
#Preview {
    @State var player = Player.test1
    return WaitView(player: $player)
        .environmentObject(GameViewModel.preview)
}
