//
//  HomeView.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-01.
//

import SwiftUI

struct DashboardView: View {
    @State private var appear = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Welcome 👋")
                            .font(.title)
                            .fontWeight(.bold)

                        Text("Track your clinic visit easily")
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .opacity(appear ? 1 : 0)
                    .offset(y: appear ? 0 : 10)

                    NavigationLink(destination: QueueStatusView()) {
                        InfoCard(title: "Queue Status",
                                 subtitle: "View your waiting time",
                                 icon: "clock",
                                 detail: "Now Serving: A-08")
                    }

                    NavigationLink(destination: ProgressView()) {
                        InfoCard(title: "Visit Progress",
                                 subtitle: "See completed steps",
                                 icon: "list.bullet.rectangle",
                                 detail: "2 of 4 complete")
                    }

                    NavigationLink(destination: ClinicMapView()) {
                        InfoCard(title: "Clinic Map",
                                 subtitle: "Find your department",
                                 icon: "map",
                                 detail: "Tap to view map")
                    }
                    
                    NavigationLink(destination: NotificationsView()) {
                        InfoCard(
                            title: "Notifications",
                            subtitle: "View visit updates",
                            icon: "bell",
                            detail: "3 new updates"
                        )
                    }

                }
                .padding()
                .animation(.easeOut(duration: 0.4), value: appear)
            }
            .navigationTitle("Clinic Flow")
            .onAppear { appear = true }
        }
    }
}
