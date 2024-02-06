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
    
    //Dismiss for .sheet
    @Environment(\.dismiss) var dismiss
    
    //Location Manager - Gets Coordinates
    @EnvironmentObject var locationManager: LocationManager
    
    //MapKit UI to follow user location
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    //Property to save coordininates: Empty array of location coordinates
    @State private var startTimer: Bool = false
    @State private var timer: Timer?
    @State private var newRunSave: Run?
    @State private var didRunStart: Bool = false
//    @State private var showNewRunSheet: Bool = false
    
    var body: some View {
        //        NavigationView {
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
                
                VStack {
                    //                    if let newRunSave {
                    //                        NewRunView(run: newRunSave)
                    //                            .frame(height: 130)
                    //                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    //                            .padding([.top, .horizontal])
                    //                    }
                    Button(action: {
                        //To Do: Logic to start saving location data
                        //Set location to center the user
                        position = .userLocation(followsHeading: true, fallback: .automatic)
                        if didRunStart == false {
                            startRun()
                            //                            showNewRunSheet.toggle()
                            didRunStart = true
                        } else {
                            stopRun()
                            didRunStart = false
                        }
                        
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(didRunStart ? .red : .green)
                                .frame(width: 150, height: 40)
                            
                            Text(didRunStart ? "Stop Run" : "Start Run")
                                .foregroundStyle(.white)
                        }
                    })
                    .padding()
                    //                        .onTapGesture {
                    //                            NavigationLink(destination: RunDetailView(run: newRunSave), label: Image(systemName: "wave.3.backward"))
                    //                        }
                    //                }
                }
                Spacer()
            }
            //            .sheet(isPresented: $showNewRunSheet, content: {
            //                NewRunView(run: newRunSave)
            //                    .presentationDetents([.height(200)])
            //                    .presentationDragIndicator(.visible)
            //            })
            .background(.ultraThinMaterial)
        }
    }
//    }
    
    func startRun() {
        let newRun = Run()
        newRunSave = newRun
        modelContext.insert(newRun)
        newRun.name = "New Run"
        //Timer here for future timer UI updates
        startTimer = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: startTimer) { _ in
            let newCoordinate = Coordinates()
            //Converting CLLLocation to swiftData! Make sure you have a property in swift data to take in new data points!
            newCoordinate.latitude = locationManager.currentUserLocation?.coordinate.latitude ?? 0
            newCoordinate.longitude = locationManager.currentUserLocation?.coordinate.longitude ?? 0
            newCoordinate.speed = locationManager.currentUserLocation?.speed ?? 0
            newCoordinate.time = Date()
            //Add Coordinate to route array
            newRun.route.append(newCoordinate)
        }
    }
    
    func stopRun() {
        //invalidate here to completely stop timer
        //Setting the @state to false only stops UI updates
        timer?.invalidate()
        timer = nil
        //set end time of the run.
        newRunSave?.endTime = Date()
        startTimer = false
    }
    
}
    
    
    
    
    
    
    
    
    /*
    
    
    
    
    //Consolidated function of Sort then convert to [CLLocationCoordinate2D] for MapPolyLine:
    private func sortedAndConvertedRouteCoordinates() -> [CLLocationCoordinate2D] {
        let sortedCoordinates = run?.route.sorted { $0.time < $1.time
        }.map { coordinate in
            CLLocationCoordinate2D(latitude: coordinate.latitude ?? 0, longitude: coordinate.longitude ?? 0)
        }

        return sortedCoordinates ?? []
    }
    
    //Total Distance of Run
    private func totalDistance(coordinates: [CLLocationCoordinate2D]) -> Double {
        let locations = coordinates.map { CLLocation(latitude: $0.latitude, longitude: $0.longitude) }
        var totalDistance: Double = 0.0
        
        for i in 1..<locations.count {
            let previous = locations[i - 1]
            let current = locations[i]
            totalDistance += current.distance(from: previous)
        }
        return totalDistance
    }
    
    //Convert Meters to Miles
    private func metersToMiles(meters: Double) -> Double {
        guard meters > 0 else { return 0.0 }
        return meters/1609.34
    }
    
    //Average speed in Meters
    private func averageSpeed() -> Double {
        let speeds = run?.route.compactMap { $0.speed }
        let totalSpeed = speeds?.reduce(0.0, +) ?? 0.0
        let avgSpeed = totalSpeed/Double(speeds?.count ?? Int(0))
    
        return avgSpeed
    }
    
    //Current speed in Meters
    private func currentSpeed() -> Double {
        return locationManager.currentUserLocation?.speed ?? 0.0
    }
    
    //meters per second to miles per hour
    private func convertToMilesPerHour(speed: Double) -> Double {
        guard speed > 0 else { return 0.0 }
        return speed * 2.23694
    }
    
    //Average Pace calculation. if Current use instantanous speed
    private func avgPace(avgSpeed: Double) -> String {
        guard avgSpeed > 0 else { return "0:00" }
        let metersPerMile = 1609.34
        let totalSecondsPerMile = metersPerMile / avgSpeed
        let minutesPerMile = Int(totalSecondsPerMile) / 60
        let secondsPerMile = Int(totalSecondsPerMile) % 60
        
        return String(format: "%d:%02d", minutesPerMile, secondsPerMile) // Format: MM:SS
        
    }
    
    */

//#Preview {
//    RunView()
//}
