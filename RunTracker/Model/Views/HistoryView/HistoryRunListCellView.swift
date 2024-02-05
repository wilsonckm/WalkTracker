//
//  HistoryRunListCellView.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/5/24.
//

import SwiftUI

struct HistoryRunListCellView: View {
    var run = Run()
    
    var body: some View {
        HStack {
            Text(run.name)
            Spacer()
            Text("\(run.startTime.formatted(.dateTime.day().month()))")
            Text("\(DurationHelper.formatDuration(duration: run.duration))")
        }
    }
}

#Preview {
    HistoryRunListCellView()
}
