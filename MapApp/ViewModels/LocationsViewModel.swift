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
    // Currrent Region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    @Published var showLocationsList: Bool = false
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
    func toggleLocationsList(){
        withAnimation(.easeInOut){
            showLocationsList = !showLocationsList
        }
    }
    func showNextLocation(location: Location){
        withAnimation(.easeInOut){
            mapLocation = location
            showLocationsList = false
        }
    }
    func nextButtonPressed(){
        // get the current index of the location
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation})
        else {
            print("Could not find current location in locations array.")
            return
        }
        // Check current Index is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // Next index is not valid so return to first
            guard let firstLocation = locations.first else {return}
            showNextLocation(location: firstLocation)
            return
        }
        // Next index is valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
        
    }
}
