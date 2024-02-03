//
//  RunView.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/3/24.
//

import SwiftUI
import SwiftData

struct RunView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var runs: [Run]
    
    var body: some View {
        VStack {
            HStack {
                Text("Runs")
                    .font(.title)
                    .bold()
                Spacer()
                Button(action: {
                    let data = Run()
                    modelContext.insert(data)
                }, label: {
                    Image(systemName: "plus")
                })
            }
            if runs.isEmpty {
                Spacer()
                Text("No Runs yet!")
                Spacer()
            } else {
                List {
                    ForEach(runs) { item in
                        HStack {
                            Text(item.id)
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
        }
        .padding()
    }
}

#Preview {
    RunView()
}
