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
    @State var isEditingName: Bool = false
    @State var runName: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    run?.name = runName
                    isEditingName = false
                    dismiss()
                }, label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .frame(width: 25, height: 20)
                })
                //Prevent saving of empty name of run
                .disabled(runName.isEmpty)
                
                if isEditingName {
                    TextField("Run Name", text: $runName)
                        .bold()
                        .font(.title)
                        .onChange(of: runName) {oldValue, newValue in
                            runName = TextFormatHelper.limitChars(input: runName, limit: 16)
                        }
                        .padding(.vertical, -1)
                } else {
                    Text(run?.name ?? "New Run")
                        .bold()
                        .font(.title)
                        .onTapGesture {
                            isEditingName = true
                        }
                }
                Spacer()
                    .onTapGesture {
                        isEditingName = true
                    }
                VStack(alignment: .trailing) {
                    Text("\(DateHelper.dateHelper(date: run?.startTime ?? Date()))")
                        .font(.caption)
                    Text("\(DateHelper.timeHelper(date: run?.startTime ?? Date()))")
                        .font(.caption)
                }
            }
            .padding(.bottom, 12)
            VStack {
                Map(){
                    MapPolyline(coordinates: sortedAndConvertedRouteCoordinates())
                        .stroke(.blue, lineWidth: 2)
                }
                .onTapGesture {
                    //Save and stop editing
                    run?.name = runName
                    //Prevent saving of empty name of run
                    if runName.isEmpty == false {
                        isEditingName = false
                    }
                }
                .padding(.horizontal, -20)
            }
            
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
                                Spacer()
                                //HR avg
                                //Max HR
                            }
                            Spacer()
                        }
                        
                    }
                }
            }
            .onTapGesture {
                run?.name = runName
                if runName.isEmpty == false {
                    isEditingName = false
                }
            }
        }
        .onAppear {
            runName = run?.name ?? "New Run"
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
        //Access + check if optional exists else returns Double
        guard let currentAltitude = run?.route.compactMap({ $0.altitude }), currentAltitude.count > 1 else {
            return 0.0
        }
        //Only adds difference if user gains elevation! Does not count for going downhill.
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
