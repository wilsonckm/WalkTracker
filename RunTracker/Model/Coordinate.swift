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
class Coordinate: Identifiable {
    @Attribute(.unique) var id: String
    var routeCoordinates: RouteCoordinates?
    var time = Date()
    var latitude: Double?
    var longitude: Double?
    
    init() {
        id = UUID().uuidString
    }
}
