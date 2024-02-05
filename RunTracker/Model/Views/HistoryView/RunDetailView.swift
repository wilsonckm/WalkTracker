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
//
//    private var runDetailsString: String {
//            guard let run = run else { return "No run data available" }
//            
//        let name = run.name 
////            let duration = run.duration ?? "Duration not available"
//            let distance = "\(run.distance) meters" // Assuming distance is stored as Double or String
//            
//            let coordinateStrings = convertedRouteCoordinates().map { coordinate in
//                "(\(coordinate.latitude), \(coordinate.longitude))"
//            }.joined(separator: ", ")
//            
//            return """
//            Name: \(name)
//            Distance: \(distance)
//            Route Coordinates: [\(coordinateStrings)]
//            """
//        }
//    
    var body: some View {
        Map(){
//            Marker("Location", coordinate: convertedRouteCoordinates())
//            MapPolyline(coordinates: runCoordinates ?? [])
//                .stroke(.blue, lineWidth: 2)
            MapPolyline(coordinates: sortedAndConvertedRouteCoordinates())
                .stroke(.blue, lineWidth: 2)
        }
       
        ScrollView{
            VStack {
//                Text(runDetailsString)
                Text("This is the detailView")
            
            }
        }
    }
    
//    //Sort Coordinates by date to organize data.
//    //Ran into bug where data would not be sorted prior to adding into database! Thereby giving weird back and forth routes of the polyline. Sorting it prior to converting to [CLLocationCoordinate2D] then having it displayed as a polyline.
    
//    private func sortRouteCoordinatesByTime() -> [Coordinates] {
//        let sortedCoordinates = run?.route.flatMap { routeCoordinates in
//            routeCoordinates.coordinates.sorted { $0.time < $1.time }
//        } 
//        return sortedCoordinates ?? []
//    }
//    
//    //Convert Array of sorted data to [CLLocationCoordinate2D]
//    private func convertedRouteCoordinates(coordinates: [Coordinates]) -> [CLLocationCoordinate2D] {
//        let convertedCoordinates = coordinates.map { coordinate in
//            CLLocationCoordinate2D(latitude: coordinate.latitude ?? 0, longitude: coordinate.longitude ?? 0)
//        }
//        return convertedCoordinates
//    }
//    
    //Consolidated function of Sort then convert to [CLLocationCoordinate2D]:
    private func sortedAndConvertedRouteCoordinates() -> [CLLocationCoordinate2D] {
        let sortedCoordinates = run?.route.sorted { $0.time < $1.time
        }.map { coordinate in
            CLLocationCoordinate2D(latitude: coordinate.latitude ?? 0, longitude: coordinate.longitude ?? 0)
        }

        return sortedCoordinates ?? []
    }
    
    // Convert CLLocationCoordinate2D to CLLocation
//    private func convertToCLLocation(locations)

}

//#Preview {
//    RunDetailView(run: )
//}
