//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by Moheb Boules on 06/12/2024.
//
import SwiftUI
import Foundation
import MapKit

class LocationsViewModel: ObservableObject{
    // All loaded locations
    @Published var locations: [Location]
    // current location on Map
    @Published var mapLocation: Location {
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init(){
        let locations = LocationsDataService.locations
        self.locations = locations

        guard let firstLocation = locations.first else {
            let defaultLocation = Location(
                name: "Default",
                cityName: "Default",
                coordinates: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                description: "The Colosseum is an oval amphitheatre in the centre of the city of Rome, Italy, just east of the Roman Forum. It is the largest ancient amphitheatre ever built, and is still the largest standing amphitheatre in the world today, despite its age.",
                imageNames: [
                   
                ],
                link: "https://en.wikipedia.org/wiki/"
            )
            
            self.mapLocation = defaultLocation
            self.updateMapRegion(location: defaultLocation)
            print("Warning: LocationsDataService.locations is empty.")
            return
        }
        self.mapLocation = firstLocation
        self.updateMapRegion(location: firstLocation)
    }
    private func updateMapRegion(location: Location){
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }
}
