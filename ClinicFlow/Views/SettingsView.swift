import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: Header
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Text("Settings")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.left")
                    .opacity(0)
            }
            .padding()
            .background(Color(red: 0.18, green: 0.41, blue: 0.45))
            
            // MARK: iOS Style List
            List {
                Section {
                    NavigationLink(destination: AppearanceView()) {
                        settingsRow(icon: "gearshape", color: .gray, title: "Appearance")
                    }
                    
                    NavigationLink(destination: AccessibilityView()) {
                        settingsRow(icon: "accessibility", color: .blue, title: "Accessibility")
                    }
                    
                    NavigationLink(destination: NotificationsView()) {
                        settingsRow(icon: "bell.fill", color: .red, title: "Notifications")
                    }
                }
                
                Section {
                    NavigationLink(destination: AboutView()) {
                        settingsRow(icon: "hand.raised.fill", color: .blue, title: "About")
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
    }
    
    func settingsRow(icon: String, color: Color, title: String) -> some View {
        HStack(spacing: 15) {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(color)
                    .frame(width: 30, height: 30)
                
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .font(.system(size: 18))
            }
            
            Text(title)
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    SettingsView()
}
