//
//  HistoryRunListCellView.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/5/24.
//

import SwiftUI

struct RunListCell: View {
    
    var run = Run()
    
    var body: some View {
        HStack {
            Text(run.name)
                .bold()
                .font(.system(size: 16))
            Spacer()
            VStack {
                Text("\(run.startTime.formatted(.dateTime.day().month()))")
                
            }
        }
    }
}

#Preview {
    RunListCell()
}
