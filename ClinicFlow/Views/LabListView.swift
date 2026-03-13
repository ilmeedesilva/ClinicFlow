import SwiftUI

import Foundation

struct Lab: Identifiable {
    let id = UUID()
    let image: String
    let name: String
    let subtitle: String
    let priceString: String
    let numericPrice: Double
}

struct LabListView: View {
    let category: String
    @State private var searchText = ""
    
    var body: some View {
        VStack(spacing: 0) {
            AppHeader(title: category)
            
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass").foregroundColor(.gray)
                    TextField("Search \(category)", text: $searchText)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(hex: "#2D6876"), lineWidth: 1)
                )
                .padding()
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(filteredLabs) { lab in

                            NavigationLink {

                                LabDetailView(
                                    testName: lab.name,
                                    price: lab.numericPrice,
                                    appointments: 10,
                                    avgTime: "15 minutes",
                                    floor: "First Floor",
                                    room: "Room No 12"
                                )

                            } label: {

                                LabRow(
                                    image: lab.image,
                                    name: lab.name,
                                    subtitle: lab.subtitle,
                                    price: lab.priceString
                                )

                            }
                            .buttonStyle(.plain)

                        }
                    }
                    .padding(.horizontal)
                }
            }
            Spacer()
        }
        .navigationBarHidden(true)
    }
    
    var filteredLabs: [Lab] {
        let labs = getLabsForCategory()
        if searchText.isEmpty {
            return labs
        } else {
            return labs.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func getLabsForCategory() -> [Lab] {
        switch category {
        case "Blood Tests":
            return [
                Lab(image: "FB", name: "Full Blood Count", subtitle: "Total health screening", priceString: "Rs. 1500.00", numericPrice: 1500),
                Lab(image: "BT", name: "Fasting Glucose", subtitle: "Blood sugar levels", priceString: "Rs. 800.00", numericPrice: 800),
                Lab(image: "LB", name: "Lipid Profile", subtitle: "Cholesterol & Triglycerides", priceString: "Rs. 2200.00", numericPrice: 2200)
            ]
        case "Urine Tests":
            return [
                Lab(image: "UTT", name: "Urine Routine", subtitle: "Full microscopic analysis", priceString: "Rs. 600.00", numericPrice: 600)
            ]
        case "Imaging & Scans":
            return [
                Lab(image: "XE", name: "Chest X-Ray", subtitle: "Standard PA view", priceString: "Rs. 2500.00", numericPrice: 2500),
                Lab(image: "AE", name: "Abdominal Ultrasound", subtitle: "Full abdomen scan", priceString: "Rs. 4500.00", numericPrice: 4500)
            ]
        case "ECG & Heart Tests":
            return [
                Lab(image: "SE", name: "Standard ECG", subtitle: "12-lead cardiac trace", priceString: "Rs. 1200.00", numericPrice: 1200),
                Lab(image: "ST", name: "Stress Test", subtitle: "Treadmill cardiac monitor", priceString: "Rs. 5000.00", numericPrice: 5000)
            ]
        default:
            return []
        }
    }
}

#Preview() {
    NavigationStack { LabListView(category: "Blood Test") }
}
