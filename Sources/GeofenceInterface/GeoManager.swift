//
//  GeoManager.swift
//
//
//  Created by Eren Erinanç on 5.05.2025.
//

import Foundation
import CoreLocation
import UserNotifications

@MainActor
public final class GeoManager: NSObject {
    public static let shared = GeoManager()
    private let locationManager = CLLocationManager()
    private var monitoredLocations: [GeoLocation] = []
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    /// Starts monitoring geofence regions for predefined locations.
    /// 
    /// You should call this method after requesting permission.
    /// This method creates `CLCircularRegion`s and starts monitoring them.
    /// 
    /// - Important: Make sure location permissions are granted and background mode is enabled.
    /// 
    /// ```swift
    /// GeoManager.shared.startGeofenceMonitoring(locations: [GeoLocation)
    /// ```
    /// - Parameter locations: GeoLocation objects to monitor.
    public func startGeofenceMonitoring(locations: [GeoLocation]) {
        self.monitoredLocations = locations
        configureRegions()
    }

    private func configureRegions() {
        for location in monitoredLocations {
            let coordinate = CLLocationCoordinate2D(
                latitude: location.latitude,
                longitude: location.longitude
            )

            let region = CLCircularRegion(
                center: coordinate,
                radius: 200,
                identifier: location.id
            )
            
            region.notifyOnEntry = true
            region.notifyOnExit = true
            locationManager.startMonitoring(for: region)
            checkIfAlreadyInsideRegion(selectedRegion: region)
        }
    }
    
    private func checkIfAlreadyInsideRegion(selectedRegion: CLCircularRegion) {
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self),
           CLLocationManager.authorizationStatus() == .authorizedAlways {
            
            for region in locationManager.monitoredRegions {
                if let circular = region as? CLCircularRegion,
                   circular.contains(locationManager.location?.coordinate ?? CLLocationCoordinate2D()) {
                    let regionName = monitoredLocations.first { $0.id == circular.identifier }?.name ?? "Unknown"
                    print("Already inside region: \(regionName)")
                }
            }
        }
    }

    
    private func handleEvent(for id: String, event: String) {
        let content = UNMutableNotificationContent()
        let regionName = monitoredLocations.first { $0.id == id }?.name ?? "Unknown"
        content.title = "\(event): \(regionName)"
        content.body = "You \(event.lowercased()) \(regionName)"
        content.sound = .default
        content.userInfo = ["regionId": id]
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: nil)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}


// MARK: - CLLocationManagerDelegate
extension GeoManager: CLLocationManagerDelegate {
    
    nonisolated public func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        let identifier = region.identifier
        Task { @MainActor in
            handleEvent(for: identifier, event: "Enter")
        }
    }
    
    nonisolated public func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        let identifier = region.identifier
        Task { @MainActor in
            handleEvent(for: identifier, event: "Exit")
        }
    }
    
    nonisolated public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Current location: \(location.coordinate)")
        }
    }

    nonisolated public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Could not get location: \(error)")
    }

}
