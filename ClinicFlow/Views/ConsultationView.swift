//
//  ConsultationView.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-05.
//

import SwiftUI

struct ConsultationView: View {
    var body: some View {
        VStack(spacing: 20) {
            InfoCard(title: "Service", subtitle: "Consultation", icon: "stethoscope", detail: "Room 03")

            InfoCard(title: "Status", subtitle: "In Progress", icon: "person.fill.checkmark", detail: "Doctor will see you shortly")

            Spacer()
        }
        .padding()
        .navigationTitle("Consultation")
    }
}
