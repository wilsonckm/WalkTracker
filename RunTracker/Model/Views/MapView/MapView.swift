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
        CLLocationCoordinate2D(latitude: 37.36513495, longitude: -122.13112023),
        CLLocationCoordinate2D(latitude: 37.36457081, longitude: -122.12476867),
        CLLocationCoordinate2D(latitude: 37.36040727, longitude: -122.11952001),
        CLLocationCoordinate2D(latitude: 37.36576171, longitude: -122.13322476),
        CLLocationCoordinate2D(latitude: 37.36522619, longitude: -122.13147671),
        CLLocationCoordinate2D(latitude: 37.36565505, longitude: -122.13287858),
        CLLocationCoordinate2D(latitude: 37.36154377, longitude: -122.1202173),
        CLLocationCoordinate2D(latitude: 37.36258266, longitude: -122.12108055),
        CLLocationCoordinate2D(latitude: 37.36436332, longitude: -122.12407817),
        CLLocationCoordinate2D(latitude: 37.36492641, longitude: -122.12966111),
        CLLocationCoordinate2D(latitude: 37.36233305, longitude: -122.12084385),
        CLLocationCoordinate2D(latitude: 37.36465673, longitude: -122.12512859),
        CLLocationCoordinate2D(latitude: 37.3658664, longitude: -122.13358057),
        CLLocationCoordinate2D(latitude: 37.36424153, longitude: -122.12374717),
        CLLocationCoordinate2D(latitude: 37.36486694, longitude: -122.12661646),
        CLLocationCoordinate2D(latitude: 37.36069305, longitude: -122.11969553),
        CLLocationCoordinate2D(latitude: 37.36396061, longitude: -122.12310285),
        CLLocationCoordinate2D(latitude: 37.36488463, longitude: -122.12699926),
        CLLocationCoordinate2D(latitude: 37.3647884, longitude: -122.12586327),
        CLLocationCoordinate2D(latitude: 37.36207862, longitude: -122.12062282),
        CLLocationCoordinate2D(latitude: 37.36489494, longitude: -122.12775531),
        CLLocationCoordinate2D(latitude: 37.36344328, longitude: -122.12218294), CLLocationCoordinate2D(latitude: 37.36483488, longitude: -122.12623861), CLLocationCoordinate2D(latitude: 37.3609743, longitude: -122.11986677), CLLocationCoordinate2D(latitude: 37.36489561, longitude: -122.12814457), CLLocationCoordinate2D(latitude: 37.36554852, longitude: -122.13253006), ]
    
    var body: some View {
        Map() {
            MapPolyline(coordinates: walkingCoordinates, contourStyle: .straight)
                .stroke(.blue, lineWidth: 2)
//            Marker("Test", coordinate: CLLocationCoordinate2D(latitude: 37.73063371, longitude: -122.43760108))
        }
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
