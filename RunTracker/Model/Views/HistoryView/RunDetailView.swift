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
    @State var runCoordinates: [CLLocationCoordinate2D]?
    
    // Computed property to convert route coordinates into CLLocationCoordinate2D array
    private func convertedRouteCoordinates() -> [CLLocationCoordinate2D] {
        return run?.route.flatMap { routeCoordinates in
            routeCoordinates.coordinates.map { coordinate in
                CLLocationCoordinate2D(latitude: coordinate.latitude ?? 0, longitude: coordinate.longitude ?? 0)
            }
        } ?? []
    }
    
    private var runDetailsString: String {
            guard let run = run else { return "No run data available" }
            
        let name = run.name 
//            let duration = run.duration ?? "Duration not available"
            let distance = "\(run.distance) meters" // Assuming distance is stored as Double or String
            
            let coordinateStrings = convertedRouteCoordinates().map { coordinate in
                "(\(coordinate.latitude), \(coordinate.longitude))"
            }.joined(separator: ", ")
            
            return """
            Name: \(name)
            Distance: \(distance)
            Route Coordinates: [\(coordinateStrings)]
            """
        }
    
    var body: some View {
        Map(){
//            Marker("Location", coordinate: convertedRouteCoordinates())
//            MapPolyline(coordinates: runCoordinates ?? [])
//                .stroke(.blue, lineWidth: 2)
            MapPolyline(coordinates: convertedRouteCoordinates())
                .stroke(.blue, lineWidth: 2)
        }
        .onAppear {
                        // Now fetching and setting the coordinates here, when the view appears.
//                        runCoordinates = convertedRouteCoordinates()
            print(convertedRouteCoordinates())
                    }
        ScrollView{
            VStack {
                Text(runDetailsString)
                Text("This is the detailView")
            
            }
        }
    }
    

}

//#Preview {
//    RunDetailView(run: )
//}
