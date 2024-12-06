//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by Moheb Boules on 06/12/2024.
//

import Foundation

class LocationsViewModel: ObservableObject{
    @Published var locations: [Location]
    init(){
        let locations = LocationsDataService.locations
        self.locations = locations
    }
}
