//
//  RunTrackerApp.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/2/24.
//

import SwiftUI
import SwiftData

@main
struct StrideWalkTracker: App {
    @AppStorage("Onboarding") var needsOnboarding = true
    var locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
            //CoreLocation defined as an environment Object
                .environmentObject(locationManager)
            //SwiftData Model setup
                .modelContainer(for: [Run.self])
            //Presents Onboarding + asks for location 
                .fullScreenCover(isPresented: $needsOnboarding) {
                    needsOnboarding = false
                } content: {
                    OnboardingView()
                        .environmentObject(locationManager)
                }
                .onAppear {
                    // If no onboarding is needed, still gets location
                    if needsOnboarding == false && locationManager.locationAuthStatus == .notDetermined {
                        locationManager.startLocationUpdates()
                    }
                }
        }
    }
}
