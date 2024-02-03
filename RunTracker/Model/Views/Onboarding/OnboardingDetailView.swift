//
//  OnboardingDetailView.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/2/24.
//

import SwiftUI

struct OnboardingDetailView: View {

    var heading: String
    var subheading: String
    var buttonAction: () -> Void
    
    var body: some View {
        VStack {
            Text("Stride")
                .font(.system(size: 28))
            Spacer()
            Text(heading)
                .font(.system(size: 28))
                .bold()
            Text(subheading)
                .font(.subheadline)
            Button {
                buttonAction()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .padding(.horizontal, 10.0)
                        .foregroundColor(.orange)
                        .frame(height: 50)
                    Text("Get Started")
                        .bold()
                        .foregroundStyle(.black)
                }
            }
        }
        .padding()
    }
}

#Preview {
    OnboardingDetailView(heading: "Make every step count.", subheading: "Track your walks, reduce your risk of falling, and reach your goals", buttonAction: {})
}
