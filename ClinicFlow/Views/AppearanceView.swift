import SwiftUI

struct AppearanceView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isDarkMode = false
    
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
                
                Text("Appearance")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.left").opacity(0)
            }
            .padding()
            .background(Color(red: 0.18, green: 0.41, blue: 0.45))
            
            // MARK: - iOS Style Settings List
            List {
                Section(header: Text("ENABLE DARK MODE")) {
                    Toggle(isOn: $isDarkMode) {
                        Text("Dark Mode")
                            .foregroundColor(.primary)
                    }
                    .tint(Color(red: 0.18, green: 0.41, blue: 0.45))
                }
            }
            .listStyle(.insetGrouped)
        }
        .navigationBarHidden(true) 
    }
}

#Preview {
    AppearanceView()
}
