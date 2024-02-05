//
//  RunView.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/3/24.
//

import SwiftUI
import SwiftData
import MapKit
import CoreLocation

struct RunView: View {
    //SwiftData
    @Environment(\.modelContext) var modelContext
    
    //Location Manager - Gets Coordinates
    @EnvironmentObject var locationManager: LocationManager
    
    //MapKit UI to follow user location
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    //Property to save coordininates: Empty array of location coordinates
    @State var startTimer: Bool = false
    @State var timer: Timer?
    @State var newRunSave: Run?
    
    var body: some View {
        Map(position: $position) {
            UserAnnotation()
        }
        .mapControls {
            MapUserLocationButton()
            MapScaleView()
            MapCompass()
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                Button(action: {
                    //To Do: Logic to start saving location data
                    
                    startRun()
                    
                    
                }, label: {
                    Text("Start Run")
                })
                .padding(.top)
                Spacer()
                Button(action: {
                    // Logic to stop saving location data and save run data
                    stopRun()
                }, label: {
                    Text("Stop Run")
                })
                .padding(.top)
                Spacer()
            }.background(.thinMaterial)
        }
        
    }
    
//    func startRun(coordinates: CLLocationCoordinate2D) {
//        let newRun = Run()
//        modelContext.insert(newRun)
//        let newRoute = RouteCoordinates()
//        newRun.route.append(newRoute)
//        //Timer here for future timer UI updates
//        startTimer = true
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: startTimer) { _ in
//            let newCoordinate = Coordinates()
//            newCoordinate.latitude = coordinates.latitude
//            newCoordinate.longitude = coordinates.longitude
//            newCoordinate.time = Date()
//            newRoute.coordinates.append(newCoordinate)
//        }
//        newRunSave = newRun
//    }
  
    func startRun() {
        let newRun = Run()
        modelContext.insert(newRun)
        let newRoute = RouteCoordinates()
        newRun.route.append(newRoute)
        //Timer here for future timer UI updates
        startTimer = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: startTimer) { _ in
            let newCoordinate = Coordinates()
            newCoordinate.latitude = locationManager.currentUserLocation?.latitude ?? 0
            newCoordinate.longitude = locationManager.currentUserLocation?.longitude ?? 0
            newCoordinate.time = Date()
            newRoute.coordinates.append(newCoordinate)
        }
        newRunSave = newRun
    }
    
    func stopRun() {
        //invalidate here to completely stop timer
        //Setting the @state to false only stops UI updates
        timer?.invalidate()
            timer = nil
        startTimer = false
    }
    
}
//#Preview {
//    RunView()
//}
