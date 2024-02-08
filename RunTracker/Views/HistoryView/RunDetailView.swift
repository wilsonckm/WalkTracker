//
//  RunDetailView.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/3/24.
//

import SwiftUI
import MapKit
import CoreLocation


struct RunDetailView: View {
    
    var run: Run?
    @EnvironmentObject var locationManager: LocationManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "chevron.backward")
                })
                Text(run?.name ?? "New Run")
                    .bold()
                    .font(.title)
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(DateHelper.dateHelper(date: run?.startTime ?? Date()))")
                        .font(.caption)
                    Text("\(DateHelper.timeHelper(date: run?.startTime ?? Date()))")
                        .font(.caption)
                }
            }
            Map(){
                MapPolyline(coordinates: sortedAndConvertedRouteCoordinates())
                    .stroke(.blue, lineWidth: 2)
            }
            .padding(.horizontal, -20)
            
            ScrollView {
                VStack {
                    VStack {
                        HStack {
                            VStack {
                                RunStat(name: "Duration", value: TextFormatHelper.formatDuration(duration: run?.duration ?? TimeInterval()) , units: "")
                                    .padding(.bottom, 15)
                                RunStat(name: "Distance", value: TextFormatHelper.doubleToTenthsStringConvert(double: metersToMiles(meters: totalDistance(coordinates:sortedAndConvertedRouteCoordinates()))), units: "mi")
                                    .padding(.bottom, 15)
                                RunStat(name: "Elev. gain", value: TextFormatHelper.doubleToTenthsStringConvert(double: altitudeCalculation()), units: "m")
                                    .padding(.bottom, 15)
                            }
                            .padding(.trailing, 50)
                            VStack {
                                RunStat(name: "Avg. Speed", value: TextFormatHelper.doubleToTenthsStringConvert(double: convertToMilesPerHour(speed: averageSpeed())), units: "mph")
                                    .padding(.bottom, 15)
                                RunStat(name: "Avg. Pace", value: avgPace(avgSpeed: averageSpeed()), units: "/mi")
                                    .padding(.bottom, 15)
                            }
                            Spacer()
                        }
                        
                    }
                    
                    Button("Edit") {
                        //To Do:
                        dismiss()
                    }
                }
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
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
    
    //Altitude/elevation gain
    private func altitudeCalculation() -> Double {
        //To do
        guard let currentAltitude = run?.route.compactMap({ $0.altitude }), currentAltitude.count > 1 else {
            return 0.0
        }
        
        var elevationGain = 0.0
        for i in 1..<currentAltitude.count {
            let difference = currentAltitude[i] - currentAltitude[i - 1]
            if difference > 0 {
                elevationGain += difference
            }
            
        }
        return elevationGain
        
    }
}
//#Preview {
//    RunDetailView(run: )
//}
