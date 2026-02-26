import SwiftUI

struct NotificationsSettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    
    @State private var allNotificationsEnabled = true
    
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
                
                Text("Notifications")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.left").opacity(0)
            }
            .padding()
            .background(Color(red: 0.18, green: 0.41, blue: 0.45))
            
            // MARK: iOS Style List
            List {
                Section(header: Text("ENABLE  ALL NOTIFICATION")) {
                    Toggle("All Notification", isOn: $allNotificationsEnabled)
                        .tint(Color(red: 0.47, green: 0.84, blue: 0.45))
                }
            }
            .listStyle(.insetGrouped)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    NotificationsSettingsView()
}
