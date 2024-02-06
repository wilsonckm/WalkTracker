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
    var run: Run?
    
    //See https://developer.apple.com/documentation/corelocation/cllocation/3861802-init for more information.
    var time = Date()
    
//    var coordinate: [CLLocationCoordinate2D] = []
    //At first the plan was to only use an array of CLLocationCordinates, however, when running into issues with SwiftData and saving values with "persisted object" error, decided to use separate lat/long variables/properties instead
    
    var latitude: Double?
    var longitude: Double?
    
    //Upon further inspection in documentation, additional CoreLocation variables can be considered such as altitude and speed found in CLLocation.
    var altitude: Double?
    var speed: Double?
    
    init() {
        id = UUID().uuidString
    }
}

