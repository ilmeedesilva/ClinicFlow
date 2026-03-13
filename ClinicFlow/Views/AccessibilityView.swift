import SwiftUI

struct AccessibilityView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedTextSize: String = "Default"
    
    var body: some View {
        VStack(spacing: 0) {

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
                
                Text("Accessibility")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.left").opacity(0)
            }
            .padding()
            .background(Color(red: 0.18, green: 0.41, blue: 0.45))
            
            List {
                Section {
                    ForEach(["Default", "Larger Text"], id: \.self) { size in
                        Button {
                            selectedTextSize = size
                        } label: {
                            HStack {
                                Text(size)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                if selectedTextSize == size {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 14, weight: .bold))
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    AccessibilityView()
}
