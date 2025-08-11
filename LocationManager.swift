//
//  LocationManager.swift
//  WeatherDemo
//
//  Created by hst on 11/08/2025.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
    }
    func requestLocation() {
        isLoading = true
        
        // Always return Pakistan coordinates
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.location = CLLocationCoordinate2D(latitude: 33.6844, longitude: 73.0479)
            self.isLoading = false
        }
    }

    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error.localizedDescription)")
        isLoading = false
    }
}
