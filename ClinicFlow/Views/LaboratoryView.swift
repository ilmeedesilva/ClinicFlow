import SwiftUI

struct LaboratoryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                Color(hex: "#2D6876")
                    .frame(height: 60)
                
                HStack {
                    Button { dismiss() } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                    }
                    Spacer()
                    Text("Request Laboratory")
                        .foregroundColor(.white)
                        .font(.headline)
                    Spacer()
                    Image(systemName: "chevron.left").opacity(0)
                }
                .padding(.horizontal)
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Medical Tests")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Wide selection of diagnostic tests")
                            .foregroundColor(.gray)
                    }
                    
                    // MARK: Categories
                    // These now navigate to LabListView with a specific category string
                    labCategoryRow(image: "BT", title: "Blood Tests", subtitle: "Wide selection of blood diagnostics")
                    labCategoryRow(image: "UT", title: "Urine Tests", subtitle: "Routine and specialized urine analysis")
                    labCategoryRow(image: "img_scan", title: "Imaging & Scans", subtitle: "X-Ray, CT, MRI and ultrasound services")
                    labCategoryRow(image: "Ecg", title: "ECG & Heart Tests", subtitle: "Cardiac diagnostics and monitoring")
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
    
    // Helper function for Category Rows
    func labCategoryRow(image: String, title: String, subtitle: String) -> some View {
        NavigationLink {
            LabListView(category: title) // Passing the title as the filter
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
                Image(systemName: "chevron.right").foregroundColor(.gray)
            }
            .padding(.vertical, 8)
        }
        .buttonStyle(.plain)
    }
}
