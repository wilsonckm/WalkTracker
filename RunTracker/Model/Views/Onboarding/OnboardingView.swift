//
//  OnboardingView.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/2/24.
//

import SwiftUI

struct OnboardingView: View {
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var locationManager: LocationManager
    @State var selectedViewIndex = 0
    
    
    var body: some View {
        TabView(selection: $selectedViewIndex) {
            OnboardingDetailView(heading: "Make every step count.", subheading: "Track your walks and check your progress") {
                withAnimation {
                    selectedViewIndex = 1
                }
            }
            .tag(0)
            
            OnboardingDetailView(heading: "Safety Prioritized", subheading: "Learn how to reduce your risk to reduce your risk of falls") {
                withAnimation {
                    selectedViewIndex = 2
                }
            }
            .tag(1)
            
            OnboardingDetailView(heading: "Privacy protected", subheading: "Your location data is necessary for this app to function propery. No location data is sent out, meaning you maintain your data.") {
                locationManager.startLocationUpdates()
                dismiss()
            }
            .tag(2)
        }
    }
}

#Preview {
    OnboardingView()
}
