//
//  QueueStatusView.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-05.
//

import SwiftUI

struct QueueStatusView: View {
    var body: some View {
        VStack(spacing: 20) {
            InfoCard(title: "Service", subtitle: "Registration", icon: "person.crop.circle", detail: "Now Serving: A-08")

            InfoCard(title: "Your Token", subtitle: "A-12", icon: "number", detail: "Estimated wait: 10 minutes")

            Text("Please wait until your number is called.")
                .font(.caption)

            Spacer()
        }
        .padding()
        .navigationTitle("Queue Status")
    }
}
