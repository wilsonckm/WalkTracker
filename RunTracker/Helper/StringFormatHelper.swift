//
//  DateHelper.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/5/24.
//

import Foundation

struct DateHelper {
    //Provides formatted month, day, and year
    static func dateHelper(date: Date) -> String {
        return date.formatted(.dateTime.day().month().year())
    }
    
    static func timeHelper(date: Date) -> String {
        return date.formatted(date: .omitted, time: .shortened)
    }
}

