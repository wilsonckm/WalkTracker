//
//  Runs.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/2/24.
//

import Foundation
import SwiftData

@Model
class Run: Identifiable {
    @Attribute(.unique) var id: String
    var name = ""
    var startTime = Date()
    var endTime = Date()
    @Relationship(deleteRule: .cascade, inverse: \RouteCoordinates.run)
    var route: [RouteCoordinates] = [RouteCoordinates]()
    var distance: Double = 0.0
    var notes = ""
    
//    init(id: String, name: String = "", startTime: Date = Date(), endTime: Date = Date(), route: [RouteCoordinates], distance: Double, notes: String = "") {
//        self.id = id
//        self.name = name
//        self.startTime = startTime
//        self.endTime = endTime
//        self.route = route
//        self.distance = distance
//        self.notes = notes
//    }
  
    init() {
        id = UUID().uuidString
    }
    var duration: TimeInterval {
        return endTime.timeIntervalSince(startTime)
    }
}
