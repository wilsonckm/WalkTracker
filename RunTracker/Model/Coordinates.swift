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
//    var coordinate: [CLLocationCoordinate2D] = []
    var latitude: Double?
    var longitude: Double?
    
    init() {
        id = UUID().uuidString
    }
}
