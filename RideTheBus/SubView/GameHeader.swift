//
//  GameHeader.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/10/23.
//

import SwiftUI
import Combine

struct GameHeader<Navigation: View, Main: View>: View {
    let user: User
    @ViewBuilder let navigation: Navigation
    @ViewBuilder let main: Main
    
    
    
    var body: some View {
        ZStack {
            VStack {
                HStack(alignment: .top) {
                    navigation
                        .padding(.horizontal)
                        .padding(.bottom, 5)
                }
                Spacer()
            }
            main
                .font(.largeTitle)
                .fontWeight(.heavy)
                .frame(maxWidth: .infinity)
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 160)
        .background(user.color.value)
    }
}




////MARK: -- EMPTY
//
//struct EmptyHeader: View {
//    var playerIcons: [IconSelection]  = IconSelection.allCases
//    var colors: [ColorSelection] = ColorSelection.allCases
//    @State var iconIndex = 0
//    @State var colorIndex = 0
//
//
//    var body: some View {
//        UserIcon(icon: playerIcons[iconIndex], color: colors[colorIndex], weight: .black)
//            .onAppear {
//                startTimers()
//            }
//    }
//
//
//    func startTimers() {
//        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
//            withAnimation {
//                iconIndex = (iconIndex + 1) % playerIcons.count
//                colorIndex = (colorIndex + 1) % colors.count
//            }
//        }
//    }
//}






//MARK: -- DEFAULT
struct DefaultHeader: View {
    var user: User
    
    var body: some View {
        HStack {
            UserIcon(user: user)
            Text(user.name)
        }
        .offset(x: -3)
    }
}

#Preview {
    @State var user = User.test1
    
    return VStack {
        GameHeader(user: User.test1, main: { DefaultHeader(user: user) })
        
        Spacer()
    }
}








//MARK: -- HOSTING
struct HostingHeader: View {
    let user: User
    let gameID: String
    
    var body: some View {
        HStack {
            UserIcon(user: user)
            VStack(alignment: .leading, spacing: 0) {
                Text("Hosting:")
                    .font(.caption)
                Text(user.name)
            }
            .offset(y: -7)
        }
        .offset(y: -10)
        .offset(x: -3)
        
        VStack {
            Spacer()
            HStack(spacing: 5) {
                ForEach(Array(gameID).indices, id: \.self) { index in
                    Text(String(Array(gameID)[index]))
                        .font(.headline)
                        .frame(width: 25, height: 25)
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(5)
                }
            }
            .padding(.bottom, 8)
        }
    }
}

#Preview {
    return VStack {
        GameHeader(user: User.test1,
                   navigation: {
            CustomBackButton(action: {})
            Spacer()
            AddPlayerButton(action: {})
        }, main: {
            HostingHeader(user: User.test1, gameID: "ASDFG")
        })
        
        Spacer()
    }
}








//MARK: -- FORM
struct FormHeader: View {
    @Binding var user: User
    let textLimit = 10
    
    var body: some View {
        ZStack {
            VStack {
                Text("Edit Player")
                    .font(.headline)
                    .padding(.top)
                Spacer()
            }
            HStack {
                UserIcon(user: user)
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white.opacity(0.2))
                        .frame(height: 70)
                        .padding(.trailing, 5)
                    TextField("", text: $user.name)
                        .placeholder(when: user.name.isEmpty) {
                            Text("Name").foregroundStyle(.white.opacity(0.8))
                        }
                        .padding(.horizontal, 16)
                        .onReceive(Just(user.name), perform: { _ in
                            limitText(textLimit)
                        })
                }
            }
            .padding([.horizontal, .top])
        }
    }
    
    func limitText(_ upper: Int) {
        if user.name.count > upper {
            user.name = String(user.name.prefix(upper))
        }
    }
}


#Preview {
    @State var user = User.test1
    
    return VStack {
        GameHeader(user: User.test1,
                   main: { FormHeader(user: $user) })
        
        Spacer()
    }
}






//MARK: -- CURRENTPLAYER
struct CurrentPlayerHeader: View {
    let user: User
    
    var body: some View {
        HStack {
            UserIcon(user: user)
            VStack(alignment: .leading, spacing: 0) {
                Text("\(user.name)'s")
                Text("Turn")
                    .font(.title)
                    .offset(y: -10)
            }
            .offset(y: 5)
        }
        .offset(x: -3)
    }
}

#Preview {
    @State var user = User.test1
    
    return VStack {
        GameHeader(user: user, main: { CurrentPlayerHeader(user: user) })
        
        Spacer()
    }
}



extension GameHeader where Navigation == EmptyView {
    init(user: User, main: () -> Main) {
        self.init(user: user, navigation: {EmptyView()}, main: main)
    }
}

