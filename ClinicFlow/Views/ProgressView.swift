//
//  ProgressView.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-01.
//

import SwiftUI

struct ProgressView: View {
    var body: some View {
        List {
            ProgressRow(title: "Registration", status: "Completed", icon: "checkmark.circle.fill")
            ProgressRow(title: "Consultation", status: "Waiting", icon: "clock.fill")
            ProgressRow(title: "Laboratory", status: "Pending", icon: "circle")
            ProgressRow(title: "Pharmacy", status: "Pending", icon: "circle")
        }
        .navigationTitle("Visit Progress")
    }
}
