//
//  RouteCoordinates.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/2/24.
//

import Foundation
import SwiftData
import MapKit

@Model
class RouteCoordinates: Identifiable {
    @Attribute(.unique) var id: String
    var run: Run?
    @Relationship(deleteRule: .cascade, inverse: \Coordinate.routeCoordinates)
    var coordinates: [Coordinate] = [Coordinate]()
    
    init() {
        id = UUID().uuidString
    }
}
