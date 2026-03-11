import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var appState: AppState
    
    @State private var homePath = NavigationPath()
    
    var body: some View {
        
        TabView(selection: $appState.selectedTab) {
            
            NavigationStack(path: $homePath) {
                HomeView()
                    .navigationDestination(for: String.self) { _ in }
            }
            .environmentObject(appState)
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            .tag(0)
            
            
            NavigationStack {
                MapView()
            }
            .environmentObject(appState)
            .tabItem {
                Image(systemName: "map")
                Text("Map")
            }
            .tag(1)
            
            
            NavigationStack {
                FamilyUsersView()
            }
            .environmentObject(appState)
            .tabItem {
                Image(systemName: "person.3")
                Text("Family Users")
            }
            .tag(2)
            
            
            NavigationStack {
                SettingsView()
            }
            .environmentObject(appState)
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
            .tag(3)
        }
        
        .onChange(of: appState.shouldReturnToHome) { _, newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    appState.selectedTab = 0
                    homePath = NavigationPath()
                    appState.shouldReturnToHome = false
                }
            }
        }
    }
}

#Preview("Main Tab View") {
    MainTabView()
        .environmentObject(AppState())
}
