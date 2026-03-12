import SwiftUI

struct PolicyView: View {
    
    let title: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            Text(title)
                .font(.system(size: 32, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.top, 30)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    
                    switch title {
                    case "Privacy Policy":
                        privacyContent
                    case "Terms and Conditions":
                        termsContent
                    case "Refund Policy":
                        refundContent
                    default:
                        Text("Content not found.")
                    }
                    
                }
                .padding(.horizontal)
            }
            
        
            Button {
                dismiss()
            } label: {
                Text("Ok")
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 150, height: 50)
                    .background(Color(red: 0.18, green: 0.41, blue: 0.45)) // The dark teal from your UI
                    .cornerRadius(10)
            }
            .padding(.bottom, 20)
        }
        .padding()
        .background(Color.white)
    }
    
    // Content 
    
    private var privacyContent: some View {
        VStack(alignment: .leading, spacing: 15) {
            policySection(title: "Data Collection", content: [
                "ClinicFlow collects only the minimum information required to provide its services, including:",
                "•  Queue number and appointment status",
                "•  Selected clinic services and booking details",
                "•  Payment transaction references",
                "•  Cancellation and refund records",
                "No sensitive medical records are stored within the application."
            ])
            
            policySection(title: "Use of Information", content: [
                "Collected data is used solely to:",
                "•  Display queue status and visit updates",
                "•  Process bookings, cancellations, and refunds",
                "•  Improve patient experience and clinic flow",
                "User data is not sold or shared with third parties."
            ])
            
            policySection(title: "Payment Data", content: [
                "ClinicFlow does not store full card details. Refund transaction records are retained only to process eligible refund requests."
            ])
            
            policySection(title: "Data Security", content: [
                "Reasonable security measures are implemented to protect user information from unauthorized access or misuse."
            ])
            
            policySection(title: "User Privacy", content: [
                "ClinicFlow respects patient confidentiality and follows general healthcare data protection principles. Users are encouraged to review this policy regularly."
            ])
        }
    }

    private var termsContent: some View {
        VStack(alignment: .leading, spacing: 15) {
            policySection(title: "Acceptance of Terms", content: [
                "By using the ClinicFlow mobile application, you agree to comply with and be bound by these Terms & Conditions."
            ])
            
            policySection(title: "Purpose of the Application", content: [
                "ClinicFlow is designed to assist patients in managing their clinic visits by providing queue status updates, visit progress tracking, navigation assistance, and notifications."
            ])
            
            policySection(title: "Appointment Cancellation", content: [
                "Patients may cancel confirmed appointments through the app. Upon cancellation:",
                "•  A 90% refund of the paid amount will be processed to the original payment method.",
                "•  The remaining 10% is retained as a non-refundable administrative fee.",
                "•  Cancellations must be made before the scheduled appointment time.",
                "•  Refunds are typically processed within 5–7 business days."
            ])
            
            policySection(title: "User Responsibilities", content: [
                "Users must ensure that the information they provide is accurate and up to date.",
                "The app should not be used for emergency medical situations.",
                "Users are responsible for cancelling appointments they cannot attend in a timely manner."
            ])
            
            policySection(title: "Limitation of Liability", content: [
                "ClinicFlow shall not be held responsible for delays, schedule changes, or service disruptions caused by clinic operations or external factors. Refund timelines may vary based on third-party payment processors."
            ])
            
            policySection(title: "Changes to Terms", content: [
                "The clinic reserves the right to update these Terms & Conditions at any time. Continued use of the app indicates acceptance of the updated terms."
            ])
        }
    }

    private var refundContent: some View {
        VStack(alignment: .leading, spacing: 15) {
            policySection(title: "Payment Processing", content: [
                "Payments made through ClinicFlow are processed for clinic services such as consultations, laboratory services, and pharmacy orders, where applicable."
            ])
            
            policySection(title: "Cancellation Refund — 90% Policy", content: [
                "When a patient cancels a confirmed appointment through the app:",
                "•  90% of the total paid amount will be refunded to the original payment method.",
                "•  The remaining 10% is a non-refundable administrative and processing fee.",
                "•  Refunds are typically processed within 5–7 business days."
            ])
            
            policySection(title: "Refund Eligibility", content: [
                "A refund is eligible when:",
                "•  The cancellation is made before the appointment time.",
                "•  The service has not yet been rendered.",
                "•  The appointment is not marked as Completed or In Progress."
            ])
            
            policySection(title: "Non-Refundable Cases", content: [
                "The following are not eligible for a refund:",
                "•  Completed services — once rendered, no refund is applicable.",
                "•  Missed appointments — no-shows are not eligible for a refund.",
                "•  Pharmacy orders where the prescription has already been dispensed."
            ])
            
            policySection(title: "Refund Process", content: [
                "Upon cancellation, the 90% refund is automatically initiated to your original payment method. A confirmation notification will be sent in the app.",
                "For disputes or further inquiries, contact the clinic directly."
            ])
        }
    }
    
    func policySection(title: String, content: [String]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .bold()
            
            ForEach(content, id: \.self) { line in
                Text(line)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}


#Preview("Privacy") {
    PolicyView(title: "Privacy Policy")
}

#Preview("Terms") {
    PolicyView(title: "Terms and Conditions")
}

#Preview("Refund") {
    PolicyView(title: "Refund Policy")
}
