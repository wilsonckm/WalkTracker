//
//  DurationHelper.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/5/24.
//

import Foundation

struct TextFormatHelper {
    
    static func formatDuration(duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        
        return formatter.string(from: duration) ?? "No Duration Found"
    }
    
    static func doubleToTenthsStringConvert(double: Double) -> String {
        return String(format: "%.1f", double)
    }
    
    
}
