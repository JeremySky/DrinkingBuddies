//
//  Color.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/5/23.
//

import SwiftUI


extension Color: RawRepresentable, Codable {
  public init?(rawValue: String) {
    do {
      let encodedData = rawValue.data(using: .utf8)!
      let components = try JSONDecoder().decode([Double].self, from: encodedData)
      self = Color(red: components[0],
                   green: components[1],
                   blue: components[2],
                   opacity: components[3])
    }
    catch {
      return nil
    }
  }
  
  public var rawValue: String {
    guard let cgFloatComponents = UIColor(self).cgColor.components else { return "" }
    let doubleComponents = cgFloatComponents.map { Double($0) }
    do {
      let encodedComponents = try JSONEncoder().encode(doubleComponents)
      return String(data: encodedComponents, encoding: .utf8) ?? ""
    }
    catch {
      return ""
    }
  }
}
