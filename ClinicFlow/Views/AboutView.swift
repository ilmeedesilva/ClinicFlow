import SwiftUI

struct AboutView: View {
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
                
                Text("About")
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
                Section {
                    Text("Clinic Flow v1.0")
                        .foregroundColor(.primary)
                    
                    Text("Designed for outpatient clinics")
                        .foregroundColor(.primary)
                }
            }
            .listStyle(.insetGrouped)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    AboutView()
}
