import SwiftUI

struct LabRow: View {
    let image: String
    let name: String
    let subtitle: String
    let price: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text(price)
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(Color(hex: "#2D6876"))
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.caption)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}
