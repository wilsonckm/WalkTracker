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
    @Relationship(deleteRule: .cascade, inverse: \Coordinates.run)
    var route: [Coordinates] = [Coordinates]()
    var distance: Double = 0.0
    var notes = ""
    var duration: TimeInterval {
        return endTime.timeIntervalSince(startTime)
    }
    
    init() {
        id = UUID().uuidString
    }
}
