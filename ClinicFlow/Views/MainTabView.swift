import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            
            NavigationStack {
                Text("Map")
            }
            .tabItem {
                Image(systemName: "map")
                Text("Map")
            }
            
            NavigationStack {
                NotificationsView()
            }
            .tabItem {
                Image(systemName: "bell")
                Text("Notifications")
            }
            
            NavigationStack {
                Text("Settings")
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
    }
}

