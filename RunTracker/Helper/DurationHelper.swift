//
//  DurationHelper.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/5/24.
//

import Foundation

struct DurationHelper {
    
    static func formatDuration(duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute]
        formatter.unitsStyle = .abbreviated
        
        return formatter.string(from: duration) ?? "No Duration Found"
    }
    
    
}
