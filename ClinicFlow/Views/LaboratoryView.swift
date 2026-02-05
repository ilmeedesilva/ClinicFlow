//
//  LaboratoryView.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-05.
//

import SwiftUI

struct LaboratoryView: View {
    var body: some View {
        VStack(spacing: 20) {
            InfoCard(title: "Service", subtitle: "Laboratory", icon: "flask", detail: "Token: L-05")

            InfoCard(title: "Estimated Wait", subtitle: "15 minutes", icon: "hourglass", detail: "Proceed when notified")

            Spacer()
        }
        .padding()
        .navigationTitle("Laboratory")
    }
}

