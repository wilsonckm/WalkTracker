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
    var walkingCoordinates = [
        CLLocationCoordinate2D(latitude: 37.64250521, longitude: -122.44464263),
        CLLocationCoordinate2D(latitude: 37.64250521, longitude: -122.44464263),
        CLLocationCoordinate2D(latitude: 37.64250521, longitude: -122.44464263),
        CLLocationCoordinate2D(latitude: 37.64250521, longitude: -122.44464263),
        CLLocationCoordinate2D(latitude: 37.64250521, longitude: -122.44464263),
        CLLocationCoordinate2D(latitude: 37.64270168, longitude: -122.44491739),
        CLLocationCoordinate2D(latitude: 37.64270168, longitude: -122.44491739),
        CLLocationCoordinate2D(latitude: 37.64270168, longitude: -122.44491739),
        CLLocationCoordinate2D(latitude: 37.64270168, longitude: -122.44491739),
        CLLocationCoordinate2D(latitude: 37.64270168, longitude: -122.44491739),
        CLLocationCoordinate2D(latitude: 37.64289488, longitude: -122.44520296),
        CLLocationCoordinate2D(latitude: 37.64289488, longitude: -122.44520296),
        CLLocationCoordinate2D(latitude: 37.64289488, longitude: -122.44520296),
        CLLocationCoordinate2D(latitude: 37.64289488, longitude: -122.44520296),
        CLLocationCoordinate2D(latitude: 37.64289488, longitude: -122.44520296),
        CLLocationCoordinate2D(latitude: 37.64289488, longitude: -122.44520296),
        CLLocationCoordinate2D(latitude: 37.64307505, longitude: -122.44550295),
        CLLocationCoordinate2D(latitude: 37.64307505, longitude: -122.44550295),
        CLLocationCoordinate2D(latitude: 37.64307505, longitude: -122.44550295),
        CLLocationCoordinate2D(latitude: 37.64307505, longitude: -122.44550295)
      ]

    
    var body: some View {
        Map() {
            MapPolyline(coordinates: walkingCoordinates, contourStyle: .straight)
                .stroke(.blue, lineWidth: 2)
//            Marker("Test", coordinate: CLLocationCoordinate2D(latitude: 37.73063371, longitude: -122.43760108))
        }
        VStack {
            Button("Print CurrentLocation") {
                print(locationManager.currentUserLocation?.coordinate.latitude ?? 0.0)
                print(locationManager.currentUserLocation?.coordinate.longitude ?? 0.0)
                //simulator does not provide altitude info!!!
                print(locationManager.currentUserLocation?.altitude ?? 0.8234)
                print(locationManager.currentUserLocation?.speed ?? 0.0)
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
