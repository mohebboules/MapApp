//
//  LocationsView.swift
//  MapApp
//
//  Created by Moheb Boules on 06/12/2024.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    @EnvironmentObject var vm: LocationsViewModel

    var body: some View {
        ZStack{
            // Map
            Map(coordinateRegion: $vm.mapRegion)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}
