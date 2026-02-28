import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        
        TabView {
            
            // MARK: Home
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            
            
            // MARK: Map
            NavigationStack {
                MapView()
            }
            .tabItem {
                Image(systemName: "map")
                Text("Map")
            }
            
            
            // MARK: Family Users
            NavigationStack {
                FamilyUsersView()
            }
            .tabItem {
                Image(systemName: "person.3")
                Text("Family Users")
            }
            
            
            // MARK: Settings
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
    }
}

#Preview("Main Tab View") {
    MainTabView()
        .environmentObject(AppState())
}
