import SwiftUI

struct PolicyView: View {
    
    let title: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                
                Spacer()
                
                Text(title)
                    .bold()
                
                Spacer()
            }
            .padding()
            
            Spacer()
            
            Text("Content Coming Soon")
                .foregroundColor(.gray)
            
            Spacer()
        }
    }
}
