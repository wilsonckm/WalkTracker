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
    var currentUserLocation: CLLocationCoordinate2D?
//    var allowsBackgroundLocatonUpdates = true
    
    var locationAuthStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
    }
    
    func getUserLocation() {
        //Check if we have permission
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            currentUserLocation = nil
//            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        //Detect if user allowed, then request location
        self.locationAuthStatus = manager.authorizationStatus
        if manager.authorizationStatus == .authorizedWhenInUse {
            currentUserLocation = nil
//            manager.requestLocation()
            locationManager.startUpdatingLocation()
        }
    }
    //What sets currentUserLocation
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if currentUserLocation == nil {
//            currentUserLocation = locations.last?.coordinate
//        }
//        
//        manager.stopUpdatingLocation()
//    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Always update currentUserLocation with the most recent location
        currentUserLocation = locations.last?.coordinate
    }

    
    
    
    //Error Handling
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //Error handling
        print("Error fetching location: \(error)")
    }

    //Start updating location
    func startLocationUpdates() {
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            currentUserLocation = nil
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    
}
