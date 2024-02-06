//
//  UserLocationManager.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/2/24.
//

import Foundation
//1. Import CoreLocation Framework
import CoreLocation
import MapKit

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    //2. Create CLLocationManager Instance
    private var locationManager = CLLocationManager()
    
//    var currentUserLocation: CLLocationCoordinate2D?
    
    var currentUserLocation: CLLocation?
    
    var locationAuthStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.allowsBackgroundLocationUpdates = true
    }
    
    //Request Permission/Authorization
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    //If user changes authorization
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.locationAuthStatus = manager.authorizationStatus
        switch manager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                currentUserLocation = nil
                locationManager.startUpdatingLocation()
            default:
                break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Always update currentUserLocation with the most recent location
    //Refactored CurrentUserLocation to take CLLocation instead of CLLocation2D
        currentUserLocation = locations.last
     
        
    }
    
    
    //Error Handling
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //Error handling
        print("Error fetching location: \(error)")
    }

    //Start updating location if authorized
//    func startLocationUpdates() {
//        if locationManager.authorizationStatus == .authorizedAlways {
//            currentUserLocation = nil
//            locationManager.startUpdatingLocation()
//        } else {
//            locationManager.requestWhenInUseAuthorization()
//        }
//    }
//    
    func startLocationUpdates() {
        switch locationManager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
//                currentUserLocation = nil
                locationManager.startUpdatingLocation()
            case .notDetermined:
            locationManager.requestWhenInUseAuthorization() // or .requestAlwaysAuthorization() depending on your needs
            default:
                break
        }
    }
    
    //Stop Function
    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }
}
