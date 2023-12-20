//
//  TEST.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/13/23.
//

import SwiftUI

struct TEST: View {
    @StateObject var game = GameManager(user: User.test1)
    
    var body: some View {
        Button("Add Player") {
        }
    }
}

#Preview {
    TEST()
}
