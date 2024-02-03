//
//  MapViewViewModel.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/3/24.
//

import Foundation

class MapViewViewModel: ObservableObject {
    
    @EnvironmentObject var locationManager: LocationManager
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
    }
    
}

func addLocationData() {
    
}

