//
//  HomeView.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-01.
//

import SwiftUI

struct HomeView: View {
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

                    NavigationLink(destination: QueueView()) {
                        InfoCard(title: "Queue Status",
                                 subtitle: "View your waiting time",
                                 icon: "clock")
                    }

                    NavigationLink(destination: ProgressView()) {
                        InfoCard(title: "Visit Progress",
                                 subtitle: "See completed steps",
                                 icon: "list.bullet.rectangle")
                    }

                    NavigationLink(destination: MapView()) {
                        InfoCard(title: "Clinic Map",
                                 subtitle: "Find your department",
                                 icon: "map")
                    }
                    
                    NavigationLink(destination: NotificationsView()) {
                        InfoCard(
                            title: "Notifications",
                            subtitle: "View visit updates",
                            icon: "bell"
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
