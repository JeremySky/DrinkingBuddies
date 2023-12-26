//
//  PlayerPoints.swift
//  RideTheBus
//
//  Created by Jeremy Manlangit on 12/12/23.
//

import Foundation


struct PlayerPoints: Codable, Hashable {
    var userID: UUID
    var points: Int
    
    init(userID: UUID, points: Int = 0) {
        self.userID = userID
        self.points = points
    }
    
    init(player: Player) {
        self.init(userID: player.user.id)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userID = try container.decode(UUID.self, forKey: .userID)
        self.points = try container.decode(Int.self, forKey: .points)
    }
    
    enum CodingKeys: CodingKey {
        case userID
        case points
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userID, forKey: .userID)
        try container.encode(self.points, forKey: .points)
    }
}
