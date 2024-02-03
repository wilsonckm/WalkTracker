//
//  Coordinate.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/3/24.
//
//
import Foundation
import SwiftData
import MapKit

@Model
class Coordinates: Identifiable {
    @Attribute(.unique) var id: String
    var routeCoordinates: RouteCoordinates?
    var time = Date()
//    var coordinate = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    var latitude: Double?
    var longitude: Double?
    
    
    //Decided to hold CLLocationCoordinate instead -- however, if working with a future external database, may need to hold values as doubles instead of CLLocationCoordinates. See Below:
    
//    private var _latitude: Double?
//    private var _longitude: Double?
//
//    var coordinate: CLLocationCoordinate2D? {
//        get {
//            guard let latitude = _latitude, let longitude = _longitude else { return nil }
//            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        }
//        set {
//            _latitude = newValue?.latitude
//            _longitude = newValue?.longitude
//        }
//    }
//    
    
    init() {
        id = UUID().uuidString
    }
}
