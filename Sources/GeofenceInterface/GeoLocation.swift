//
//  GeoLocation.swift
//  GeofenceInterface
//
//  Created by Eren Erinanç on 5.05.2025.
//

import Foundation

public struct GeoLocation {
    public let name: String
    public let latitude: Double
    public let longitude: Double
    
    public init(
        name: String,
        latitude: Double,
        longitude: Double
    ) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
