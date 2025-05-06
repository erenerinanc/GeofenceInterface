//
//  GeoLocation.swift
//  GeofenceInterface
//
//  Created by Eren Erinanç on 5.05.2025.
//

import Foundation

public struct GeoLocation {
    public let id: String
    public let name: String
    public let latitude: Double
    public let longitude: Double
    
    public init(
        id: String,
        name: String,
        latitude: Double,
        longitude: Double
    ) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension GeoLocation {
    public enum Event: String {
        case enter
        case exit
    }
}
