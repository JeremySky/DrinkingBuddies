//
//  View.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 1/2/24.
//

import Foundation
import SwiftUI


//For modifying TextField's default text's color
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
