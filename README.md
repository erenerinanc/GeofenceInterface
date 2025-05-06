# GeofenceInterface SDK

GeofenceInterface is a lightweight Swift SDK that enables geofencing functionality in iOS apps.  
It allows developers to define specific geographic areas and receive notifications when the user enters or exits those areas — even in the background or when the app is terminated (depending on iOS behavior).

---

## 🚀 Installation

### Swift Package Manager

Add the following to your `Package.swift` dependencies:

```swift
.package(url: "https://github.com/erenerinanc/GeofenceInterface.git", from: "1.0.0")
```

Then add "GeofenceInterface" to your target dependencies:

```swift
import GeofenceInterface
```

## 👀 Start Tracking 

### Prepare your list of GeoLocation

```swift
let locations = [
    GeoLocation(name: "Kadıköy", latitude: 40.9890, longitude: 29.0280),
    GeoLocation(name: "Alsancak", latitude: 38.4332, longitude: 27.1302),
]
```

### Start Monitoring

```swift
GeoManager.shared.startGeofenceMonitoring(locations: locations)
```

### Stop monitoring (e.g. after notification is tapped)

```swift
GeoManager.shared.stopMonitoring()
```

## 🚨 Required Permissions

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to provide geo-based magic.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>We need your location even in the background to detect entry and exit.</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>We need your location always to detect geofence events even when the app is closed.</string>
<key>NSUserNotificationUsageDescription</key>
<string>We use notifications to inform you when you enter or exit a geofence.</string>

```

**Also, enable the following capability:**

Background Modes → Location Updates

