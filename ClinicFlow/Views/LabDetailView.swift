import SwiftUI

struct LabDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let testName: String
    let price: Double
    let appointments: Int
    let avgTime: String
    let floor: String
    let room: String
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: Header
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
                    
                    Text(testName)
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.left")
                        .opacity(0)
                }
                .padding(.horizontal)
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: Test Info
                    HStack(spacing: 16) {
                        Image("BT")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Complete Blood Count")
                                .font(.headline)
                            
                            Text("Full blood cell analysis")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Text("Rs. \(Int(price)).00")
                                .fontWeight(.bold)
                        }
                    }
                    
                    Divider()
                    
                    // MARK: Stats
                    HStack {
                        InfoStatView(
                            icon: "appointment-icon",
                            title: "Appointments",
                            value: "14"
                        )
                        
                        Divider()
                            .frame(height: 50)
                        
                        InfoStatView(
                            icon: "clock-icon",
                            title: "Avg Est. time",
                            value: "15 minutes"
                        )
                    }
                    .padding(.vertical, 4)

                    
                    Divider()
                    
                    // MARK: Instructions
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Instructions")
                            .font(.headline)
                        
                        bulletPoint("Fasting is not required for this test.")
                        bulletPoint("Drink water before your appointment.")
                        bulletPoint("Inform staff if you are taking any medications.")
                    }
                    
                    Divider()
                    
                    // MARK: Location
                    LocationMapView()
                    
                    Spacer(minLength: 40)
                }
                .padding()
            }
            
            // MARK: Continue Button
            NavigationLink {
                PaymentView(
                    item: BookableItem(
                        serviceType: .laboratory,
                        title: "Complete Blood Count",
                        subtitle: "Full blood cell analysis",
                        price: 800,
                        image: "BT",
                        room: "Room 101",
                        floor: "1st floor"
                    )
                )
            } label: {
                Text("Continue to Payment")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#2D6876"))
                    .cornerRadius(14)
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
    
    // MARK: Bullet View
    
    func bulletPoint(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
            Text(text)
                .font(.caption)
        }
    }
}

#Preview("Lab Detail Preview") {
    NavigationStack {
        LabDetailView(
            testName: "Blood Tests",
            price: 800,
            appointments: 10,
            avgTime: "15 minutes",
            floor: "First Floor",
            room: "Room No 12"
        )
    }
}
