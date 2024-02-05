//
//  MapView.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/3/24.
//

import SwiftUI
import MapKit
import SwiftData

struct MapView: View {
    @EnvironmentObject var locationManager: LocationManager
//    @State var coordinateArray = Coordinates()
    
    var body: some View {
        VStack {
            Button("Print CurrentLocation") {
                print(locationManager.currentUserLocation?.latitude ?? 0.0)
                print(locationManager.currentUserLocation?.longitude ?? 0.0)
            }
        }
    }
    
//    func addLocationData() {
//        coordinateArray.latitude = locationManager.currentUserLocation?.latitude ?? 0
//        coordinateArray.longitude = locationManager.currentUserLocation?.longitude ?? 0
//            
////            .append(locationManager.currentUserLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
//        
//    }
}

#Preview {
    MapView()
}
