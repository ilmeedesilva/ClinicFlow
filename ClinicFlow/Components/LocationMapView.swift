import SwiftUI

struct LocationMapView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Text("Location")
                .font(.headline)
            
            Text("Ground Floor")
                .foregroundColor(.gray)
                .font(.caption)
            
            Text("Room No 204")
                .foregroundColor(.gray)
                .font(.caption)
                
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.lightGrayBG)
                    .frame(height: 200)
                
                VStack {
                    Image(systemName: "mappin.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray.opacity(0.5))
                    
                    Text("Clinic Map Preview")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}
