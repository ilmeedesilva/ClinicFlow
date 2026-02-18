import SwiftUI

struct LaboratoryView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: Custom Header
            ZStack {
                Color(hex: "#2D6876")
                    .frame(height: 60)
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                    }
                    
                    Spacer()
                    
                    Text("Request Laboratory")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    Spacer()
                    
                    // For balance
                    Image(systemName: "chevron.left")
                        .opacity(0)
                }
                .padding(.horizontal)
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: Title Section
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Medical Tests")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Wide selection of diagnostic tests")
                            .foregroundColor(.gray)
                    }
                    
                    // MARK: Search Box
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("search", text: $searchText)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    
                    // MARK: Lab Categories
                    labRow(
                        image: "BT",
                        title: "Blood Tests",
                        subtitle: "Wide selection of blood diagnostics"
                    )
                    
                    labRow(
                        image: "UT",
                        title: "Urine Tests",
                        subtitle: "Routine and specialized urine analysis"
                    )
                    
                    labRow(
                        image: "img-scan",
                        title: "Imaging & Scans",
                        subtitle: "X-Ray, CT, MRI and ultrasound services"
                    )
                    
                    labRow(
                        image: "ECG",
                        title: "ECG & Heart Tests",
                        subtitle: "Cardiac diagnostics and monitoring"
                    )
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: Lab Row Component
    
    func labRow(image: String, title: String, subtitle: String) -> some View {
        NavigationLink {
            LabDetailView(
                    testName: title,
                    price: 800,
                    appointments: 10,
                    avgTime: "15 minutes",
                    floor: "First Floor",
                    room: "Room No 12"
                )
        } label: {
            HStack(spacing: 16) {
                
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 8)
        }
        .buttonStyle(.plain)
    }
}

#Preview {

        LaboratoryView()
}
