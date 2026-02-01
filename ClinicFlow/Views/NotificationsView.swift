//
//  NotificationsView.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-01.
//

import SwiftUI

struct NotificationsView: View {
    let notifications = [
        "Your consultation will begin in 5 minutes",
        "Please proceed to Consultation Room 3",
        "Registration completed successfully"
    ]

    var body: some View {
        List(notifications, id: \.self) { note in
            HStack(spacing: 12) {
                Image(systemName: "bell.fill")
                    .foregroundColor(.blue)

                Text(note)
            }
            .padding(.vertical, 6)
        }
        .navigationTitle("Notifications")
    }
}
