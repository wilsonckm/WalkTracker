//
//  RunView.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/3/24.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        RunListView()
    }
}

#Preview {
    HistoryView()
}
