import SwiftUI

struct PharmacyUploadView: View {
    
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: Header
            AppHeader(title: "Pharmacy")
            
            VStack(alignment: .leading, spacing: 20) {
                
                // Title
                Text("Upload Your Prescription")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text("Please upload a clear photo of your prescription")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                // MARK: Upload Box
                VStack(spacing: 20) {
                    
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.system(size: 40))
                        .foregroundColor(Color(hex: "#2D6876"))
                    
                    Text("Upload Prescription here")
                        .font(.headline)
                    
                    HStack(spacing: 16) {
                        
                        Button {
                            print("Open Gallery")
                        } label: {
                            Text("Gallery")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "#2D6876"))
                                .cornerRadius(12)
                        }
                        
                        Button {
                            print("Open Camera")
                        } label: {
                            Text("Camera")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "#2D6876"))
                                .cornerRadius(12)
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(hex: "#A8D0C6"))
                .cornerRadius(20)
                
                Text("Please upload a clear photo of your prescription")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                // MARK: Submit Button
                NavigationLink {
                    PharmacyQueueView(
                        item: BookableItem(
                            serviceType: .pharmacy,
                            title: "Prescription Order",
                            subtitle: "Medicine Collection",
                            price: 0,
                            image: "pharmacy-icon",
                            room: "Counter 03",
                            floor: "First Floor"
                        )
                    )
                } label: {
                    Text("Submit Prescription")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#2D6876"))
                        .cornerRadius(14)
                }
            }
            .padding()
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

#Preview("Pharmacy Upload") {
    NavigationStack {
        PharmacyUploadView()
    }
}

