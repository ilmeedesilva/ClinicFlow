import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem { Label("Home", systemImage: "house") }

            QueueStatusView()
                .tabItem { Label("Queue", systemImage: "clock") }

            VisitProgressView()
                .tabItem { Label("Progress", systemImage: "list.bullet") }

            ClinicMapView()
                .tabItem { Label("Map", systemImage: "map") }

            NotificationsView()
                .tabItem { Label("Alerts", systemImage: "bell") }

            SettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}

#Preview {
    MainTabView()
}
