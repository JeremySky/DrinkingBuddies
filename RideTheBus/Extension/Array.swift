//
//  Array.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/13/23.
//

import Foundation

extension Array where Element: Codable {
    var toDictionary: [String: Any]? {
        var dictionary: [String: Any] = [:]
        
        for (index, element) in self.enumerated() {
            dictionary[String(index)] = element.toDictionary
        }
        
        return dictionary.isEmpty ? nil : dictionary
    }
}
