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
    @Published var mapLocation: Location
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion(){
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init(){
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        self.updateMapRegion(location: locations.first!)
    }
    private func updateMapRegion(location: Location){
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }
}
