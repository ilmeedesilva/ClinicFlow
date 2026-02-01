//
//  MapView.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-01.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        VStack(spacing: 20) {

            Image(systemName: "building.2.crop.circle")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .foregroundColor(.blue)

            Text("Select a Department")
                .font(.headline)

            List {
                Label("Registration Counter", systemImage: "person.text.rectangle")
                Label("Consultation Room", systemImage: "stethoscope")
                Label("Laboratory", systemImage: "cross.case.fill")
                Label("Pharmacy", systemImage: "pills.fill")
            }
        }
        .navigationTitle("Clinic Map")
    }
}
