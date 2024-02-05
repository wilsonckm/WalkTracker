//
//  NewRun.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/3/24.
//

import SwiftUI
import MapKit

struct NewRun: View {
    var newRun: Run
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        Map() {
            
        }
        
    }
}

//#Preview {
//    NewRun()
//}
