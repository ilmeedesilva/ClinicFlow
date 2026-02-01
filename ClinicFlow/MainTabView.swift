//
//  MainTabView.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-01.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            QueueView()
                .tabItem {
                    Label("Queue", systemImage: "clock.fill")
                }

            MapView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}
