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
                    //                        locationManager.startLocationUpdates()
                    print(locationManager.currentUserLocation?.latitude ?? 0.0)
                    print(locationManager.currentUserLocation?.longitude ?? 0.0)
                }, label: {
                    Text("Start Run")
                })
                .padding(.top)
                Spacer()
                Button(action: {
                    // Logic to stop saving location data and save run data
//                    saveRun(routeCoordinates: locationManager.routeCoordinates)
                    
                    saveCoordinates(coordinates: locationManager.currentUserLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
//                    locationManager.stopLocationUpdates()
                    //                        let runData = Run(routeCoordinates: locationManager.routeCoordinates)
                    //                        modelContext.insert(runData)
                }, label: {
                    Text("Stop Run")
                })
                .padding(.top)
                Spacer()
            }.background(.thinMaterial)
        }
        
    }
    func saveCoordinates(coordinates: CLLocationCoordinate2D) {
        let newRun = Run()
        let newRoute = RouteCoordinates()
        let newCoordinate = Coordinates()
        newCoordinate.latitude = coordinates.latitude
        newCoordinate.longitude = coordinates.longitude
        newCoordinate.time = Date()
        newRoute.coordinates.append(newCoordinate)
        newRun.route.append(newRoute)
        modelContext.insert(newRun)
    }
    
    
    
    func saveRun(routeCoordinates: [CLLocationCoordinate2D]) {
        let newRun = Run()
        // Set properties for `newRun` like startTime, endTime, distance, etc.
        
        // Assuming you have a relationship setup where Run has many RouteCoordinates,
        // and each RouteCoordinates instance can have many Coordinates
        let newRoute = RouteCoordinates() // Create a RouteCoordinates instance for this run
        
        for coordinate in routeCoordinates {
            let newCoordinate = Coordinates() // Create a new Coordinates instance
            newCoordinate.latitude = coordinate.latitude
            newCoordinate.longitude = coordinate.longitude
            newCoordinate.time = Date() // Assuming each coordinate is tagged with the current time
            
            // Link the Coordinates instance to the RouteCoordinates instance
            // Assuming `newRoute.coordinates` is designed to hold instances of Coordinates
            newRoute.coordinates.append(newCoordinate)
        }
        
        // Link the RouteCoordinates instance to the Run instance
        // Assuming `newRun.route` can hold one or many RouteCoordinates instances
        newRun.route.append(newRoute)
        
        // Save the newRun instance to the database
        // This typically involves calling some form of save or insert method provided by your data handling framework
        // Replace `modelContext.insert(newRun)` with the actual method you use to save `newRun` to your database
        modelContext.insert(newRun)
    }
}
#Preview {
    RunView()
}
