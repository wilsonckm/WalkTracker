//
//  RunDetailView.swift
//  RunTracker
//
//  Created by Wilson Chan on 2/3/24.
//

import SwiftUI
import MapKit

struct RunDetailView: View {
    
    var run: Run?
    
    //Computed property: Convert from data into CLLocationCoordinate2D
//    private func converedRouteCoordinates() -> [CLLocationCoordinate2D] {
//        run?.route.flatMap { routeCoordinates in
//            routeCoordinates.coordinates.map { coordinate in
//                CLLocationCoordinate2D(latitude: coordinate.latitude ?? 0, longitude: coordinate.longitude ?? 0)
//            }
//        } ?? []
//    }
    
//    private var string: String {
//        let coordinateStrings = converedRouteCoordinates().map { coordinate in
//            "(\(coordinate.latitude), \(coordinate.longitude))"
//        }
//        return coordinateStrings.joined(separator: ", ")
//    }
    // Computed property to convert route coordinates into CLLocationCoordinate2D array
    private func convertedRouteCoordinates() -> [CLLocationCoordinate2D] {
        run?.route.flatMap { routeCoordinates in
            routeCoordinates.coordinates.map { coordinate in
                CLLocationCoordinate2D(latitude: coordinate.latitude ?? 0, longitude: coordinate.longitude ?? 0)
            }
        } ?? []
    }
    
    private var runDetailsString: String {
            guard let run = run else { return "No run data available" }
            
            let name = run.name ?? "Unnamed Run"
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
            MapPolyline(coordinates: convertedRouteCoordinates())
        }
        VStack {
//            Text(string)
            Text(run?.name ?? "Run Name")
            Text(runDetailsString)
            Text("This is the detailView")
        
            
            
//            Text(run?.duration)
//            Text(run.distance)
        }
    }
    

}

//#Preview {
//    RunDetailView(run: )
//}
