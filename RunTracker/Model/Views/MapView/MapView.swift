//
//  MapView.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/3/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        Map() {
            UserAnnotation()
        }
        Button("Add location") {
            addLocationData()
        }
    }
    
    func addLocationData() {
        print("\(locationManager.currentUserLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0) )")
    }
}

#Preview {
    MapView()
}
