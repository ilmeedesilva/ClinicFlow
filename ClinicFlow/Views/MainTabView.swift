import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var appState: AppState
    
    @State private var homePath = NavigationPath()
    @State private var selectedTab = 0
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            NavigationStack(path: $homePath) {
                HomeView()
                    .navigationDestination(for: String.self) { _ in }
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            .tag(0)
            
            
            NavigationStack {
                MapView()
            }
            .tabItem {
                Image(systemName: "map")
                Text("Map")
            }
            .tag(1)
            
            
            NavigationStack {
                FamilyUsersView()
            }
            .tabItem {
                Image(systemName: "person.3")
                Text("Family Users")
            }
            .tag(2)
            
            
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
            .tag(3)
        }
        
        .onChange(of: appState.shouldReturnToHome) { _, newValue in
            if newValue {
                selectedTab = 0
                homePath = NavigationPath() 
                appState.shouldReturnToHome = false
            }
        }
    }
}

#Preview("Main Tab View") {
    MainTabView()
        .environmentObject(AppState())
}
