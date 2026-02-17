import SwiftUI

struct PaymentSuccessView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            
            // MARK: Background
            Color(Color.successBackround)
                .ignoresSafeArea()
            
            VStack {
                
                Spacer(minLength: 80)
                
                ZStack {
                    
                    // MARK: White Card
                    VStack(spacing: 28) {
                        
                        Spacer().frame(height: 50)
                        
                        Text("You have successfully made")
                            .font(.title3)
                        
                        Text("an appointment")
                            .font(.title3)
                
                        
                        // Doctor Image
                        Image("doctor1")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        VStack(spacing: 4) {
                            Text("Dr. Stone Gaze")
                                .font(.headline)
                            
                            Text("Ear, Nose & Throat specialist")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer().frame(height: 10)
                        
                        // MARK: Appointment Details
                        HStack(alignment: .center, spacing: 12) {
                            
                            Image("appointment-icon")
                                .font(.title2)
                                .foregroundColor(.black)
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Appointment")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Text("No 14")
                                    .fontWeight(.bold)
                                
                                Text("Room 204")
                                    .fontWeight(.bold)
                                
                                Text("10 Feb 2026, 11:00")
                                    .fontWeight(.bold)
                            }
                        }
                        .padding(.top, 10)
                        
                        Spacer()
                        
                        // MARK: Back Button
                        Button {
                            appState.hasActiveAppointment = true
                            dismiss()
                        } label: {
                            Text("Back to home")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "#2D6876"))
                                .cornerRadius(14)
                        }

                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                    
                    // MARK: Floating Success Icon
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .frame(width: 90, height: 90)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(hex: "#2D6876"), lineWidth: 6)
                                )
                            
                            Image("success")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(Color(hex: "#2D6876"))
                        }
                        .offset(y: -45) // 👈 Proper position
                        
                        Spacer()
                    }
                }
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
    }
}


#Preview {
    ZStack {
        PaymentSuccessView()
    }
}
