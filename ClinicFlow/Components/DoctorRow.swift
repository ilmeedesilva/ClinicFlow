import SwiftUI

struct DoctorRow: View {
    
    let imageName: String
    let name: String
    let subtitle: String
    let price: String
    
    var body: some View {
        HStack {
            
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .bold()
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(price)
                    .bold()
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")  
                .foregroundColor(.gray)
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
    }
}
