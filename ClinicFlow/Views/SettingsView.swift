//
//  SettingsView.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-01.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var largeText = false

    var body: some View {
        Form {
            Section(header: Text("Appearance")) {
                Toggle("Dark Mode", isOn: $isDarkMode)
            }

            Section(header: Text("Accessibility")) {
                Toggle("Enable Large Text", isOn: $largeText)
            }

            Section(header: Text("About")) {
                Text("Clinic Flow v1.0")
                Text("Designed for outpatient clinics")
            }
        }
        .navigationTitle("Settings")
    }
}

