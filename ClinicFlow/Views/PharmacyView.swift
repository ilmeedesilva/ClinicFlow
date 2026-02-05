//
//  PharmacyView.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-05.
//

import SwiftUI

struct PharmacyView: View {
    var body: some View {
        VStack(spacing: 20) {
            InfoCard(title: "Prescription Status", subtitle: "Preparing", icon: "pills", detail: "Medication in progress")

            InfoCard(title: "Pickup Time", subtitle: "5 minutes", icon: "clock", detail: "You will be notified")

            Spacer()
        }
        .padding()
        .navigationTitle("Pharmacy")
    }
}

