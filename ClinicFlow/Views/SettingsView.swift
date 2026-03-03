import SwiftUI

struct SettingsView: View {

    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    
    @State private var showLogoutPopup = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Spacer()
                    Text("Settings")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .background(Color(red: 0.18, green: 0.41, blue: 0.45))
                
                List {
                    Section {
                        NavigationLink(destination: AppearanceView()) {
                            settingsRow(icon: "gearshape", color: .gray, title: "Appearance")
                        }
                        NavigationLink(destination: AccessibilityView()) {
                            settingsRow(icon: "accessibility", color: .blue, title: "Accessibility")
                        }
                        NavigationLink(destination: NotificationsSettingsView()) {
                            settingsRow(icon: "bell.fill", color: .red, title: "Notifications")
                        }
                    }
                    
                    Section {
                        NavigationLink(destination: AboutView()) {
                            settingsRow(icon: "hand.raised.fill", color: .blue, title: "About")
                        }
                    }
                    
                    // Logout
                    Section {
                        Button(action: {
                            withAnimation {
                                showLogoutPopup = true
                            }
                        }) {
                            HStack {
                                Spacer()
                                Text("Log out")
                                    .foregroundColor(.red)
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            .blur(radius: showLogoutPopup ? 3 : 0)
            .disabled(showLogoutPopup)
            
            if showLogoutPopup {
                LogoutOverlayView(
                    title: "Log Out",
                    subtitle: "Are you sure you want to log out?",
                    confirmButtonTitle: "Log Out",
                    cancelButtonTitle: "Cancel",
                    onConfirm: {
                        appState.logout()
                        showLogoutPopup = false
                    },
                    onCancel: {
                        showLogoutPopup = false
                    }
                )
                .transition(.opacity.combined(with: .scale(scale: 1.1)))
            }
        }
    }
    
    func settingsRow(icon: String, color: Color, title: String) -> some View {
        HStack(spacing: 15) {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(color)
                    .frame(width: 30, height: 30)
                Image(systemName: icon).foregroundColor(.white).font(.system(size: 18))
            }
            Text(title).foregroundColor(.primary)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppState())
}
