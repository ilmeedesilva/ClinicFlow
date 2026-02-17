import SwiftUI

struct AppHeader: View {
    
    let title: String
    var showBackButton: Bool = true
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            
            if showBackButton {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold))
                }
            }
            
            Spacer()
            
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .bold))
            
            Spacer()
            
            // Invisible spacer for symmetry
            if showBackButton {
                Image(systemName: "chevron.left")
                    .opacity(0)
            }
        }
        .padding()
        .background(Color.headerColor)
    }
}
