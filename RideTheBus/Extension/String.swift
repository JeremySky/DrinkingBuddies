//
//  String.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/11/23.
//

import Foundation


extension String {
    static func randomGameID() -> String {
      let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789"
      return String((0..<5).map{ _ in letters.randomElement()! })
    }
}
