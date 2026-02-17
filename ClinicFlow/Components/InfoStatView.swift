import SwiftUI

struct InfoStatView: View {
    
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding(.top, 2) 
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text(title)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                
                Text(value)
                    .font(.system(size: 16, weight: .bold))
            }
        }
        .frame(maxWidth: .infinity)
    }
}
