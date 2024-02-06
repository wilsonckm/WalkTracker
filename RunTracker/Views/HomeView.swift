//
//  ContentView.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/2/24.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        TabView {
            HistoryView()
                .tabItem {
                    VStack {
                        Image(systemName: "lines.measurement.horizontal")
                        Text("History")
                    }
                }
            RunView()
                .tabItem {
                    VStack {
                        Image(systemName: "figure.run")
                        Text("Run")
                    }
                }
            MapView()
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                }
        }
    }
}

//#Preview {
//    HomeView()
//}
