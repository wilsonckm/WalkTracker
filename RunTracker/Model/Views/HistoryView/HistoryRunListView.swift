//
//  RunListView.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/3/24.
//

import SwiftUI
import SwiftData

struct RunListView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var runs: [Run]
    @State private var presentedRuns: [Run] = []
    
    var body: some View {
        NavigationStack(path: $presentedRuns) {
            ZStack {
                if runs.isEmpty {
                    Spacer()
                    Text("No Runs yet!")
                    Spacer()
                } else {
                    List {
                        ForEach(runs) { item in
                            NavigationLink(value: item) {
                                HStack {
                                    //RunCellView?
                                    Text(item.name)
                                    Spacer()
                                    Text("\(item.duration)")
                                }
                                .swipeActions {
                                    Button("Delete") {
                                        modelContext.delete(item)
                                    }
                                }
                            }
                        }
                    }
                    .navigationDestination(for: Run.self) { run in
                        RunDetailView(run: run)
                    }
                    .listStyle(.plain)
                    .navigationTitle("History")
                }
            }
        }
    }
}

#Preview {
    RunListView()
}
