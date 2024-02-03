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
    var notes = ""
    
    init(id: String, name: String = "", startTime: Date = Date(), endTime: Date = Date(), route: [RouteCoordinates], notes: String = "") {
        self.id = id
        self.name = name
        self.startTime = startTime
        self.endTime = endTime
        self.route = route
        self.notes = notes
    }
}
