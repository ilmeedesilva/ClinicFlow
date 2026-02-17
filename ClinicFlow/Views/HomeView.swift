import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Wavy Header Image
            ZStack(alignment: .bottomLeading) {
                
                Image("Hospitalimg")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 280)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 30)
                    )
                    .ignoresSafeArea(edges: .top)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Welcome!")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("May you always in a good condition")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            
            ScrollView {
                VStack(spacing: 16) {
                    
                    HStack(spacing: 16) {
                        
                        NavigationLink {
                            AppointmentView()
                        } label: {
                            HomeCard(
                                imageName: "homecard-docimg",
                                title: "Doctor/\nConsultation",
                                subtitle: "Find a Doctor or specialist",
                                background: Color(hex: "#E2EAFF")
                            )
                        }
                        
                        NavigationLink {
                            Text("Queue Screen")
                        } label: {
                            HomeCard(
                                imageName: "homecard-queueimg",
                                title: "Queue Status",
                                subtitle: "Monitor your visit progress",
                                background: Color(hex: "#EDFCF2")
                            )
                        }
                    }
                    
                    HStack(spacing: 16) {
                        
                        NavigationLink {
                            Text("Lab Flow")
                        } label: {
                            HomeCard(
                                imageName: "homecard-labimg",
                                title: "Request\nLaboratory",
                                subtitle: "Get your lab reports",
                                background: Color(hex: "#FEF6EE")
                            )
                        }
                        
                        NavigationLink {
                            Text("Pharmacy Flow")
                        } label: {
                            HomeCard(
                                imageName: "homecard-pharmacyimg",
                                title: "Locate a\nPharmacy",
                                subtitle: "Purchase Medicines",
                                background: Color(hex: "#FDCEC9")
                            )
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
            }

        }
        .navigationBarHidden(false)
    }
}

#Preview {
    NavigationStack { HomeView() }
}
#Preview {
    MainTabView()
}
