//
//  MapAppApp.swift
//  MapApp
//
//  Created by Moheb Boules on 06/12/2024.
//

import SwiftUI

@main
struct MapAppApp: App {
    
    @StateObject var vm: LocationsViewModel = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
