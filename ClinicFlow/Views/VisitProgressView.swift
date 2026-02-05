//
//  VisitProgressView.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-05.
//

import SwiftUI

struct VisitProgressView: View {
    var body: some View {
        VStack(spacing: 12) {
            ProgressRow(title: "Registration", status: "Completed", icon: "checkmark.circle.fill")
            ProgressRow(title: "Consultation", status: "Completed", icon: "checkmark.circle.fill")
            ProgressRow(title: "Laboratory", status: "Pending", icon: "hourglass")
            ProgressRow(title: "Pharmacy", status: "Pending", icon: "hourglass")

            Spacer()
        }
        .padding()
        .navigationTitle("Visit Progress")
    }
}
