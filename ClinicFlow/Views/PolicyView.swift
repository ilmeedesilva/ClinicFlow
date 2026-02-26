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
    
    // Content Sections
    
    private var privacyContent: some View {
        VStack(alignment: .leading, spacing: 15) {
            policySection(title: "Data Collection", content: [
                "Clinic Flow collects only the minimum information required to provide its services, such as:",
                "•  Queue number",
                "•  Appointment status",
                "•  Selected clinic services",
                "No sensitive medical records are stored within the application."
            ])
            
            policySection(title: "Use of Information", content: [
                "Collected data is used solely to:",
                "•  Display queue status",
                "•  Provide visit updates",
                "•  Improve patient experience and clinic flow",
                "User data is not sold or shared with third parties."
            ])
            
            policySection(title: "Data Security", content: [
                "Reasonable security measures are implemented to protect user information from unauthorized access or misuse."
            ])
            
            policySection(title: "User Privacy", content: [
                "Clinic Flow respects patient confidentiality and follows general healthcare data protection principles. Users are encouraged to review this policy regularly."
            ])
        }
    }
    
    private var termsContent: some View {
        VStack(alignment: .leading, spacing: 15) {
            policySection(title: "Acceptance of Terms", content: [
                "By using the Clinic Flow mobile application, you agree to comply with and be bound by these Terms & Conditions."
            ])
            
            policySection(title: "Purpose of the Application", content: [
                "Clinic Flow is designed to assist patients in managing their clinic visits by providing queue status updates, visit progress tracking, navigation assistance, and notifications."
            ])
            
            policySection(title: "User Responsibilities", content: [
                "Users must ensure that the information they provide is accurate and up to date.",
                "The app should not be used for emergency medical situations."
            ])
            
            policySection(title: "Limitation of Liability", content: [
                "Clinic Flow shall not be held responsible for delays, schedule changes, or service disruptions caused by clinic operations or external factors."
            ])
            
            policySection(title: "Changes to Terms", content: [
                "The clinic reserves the right to update these Terms & Conditions at any time. Continued use of the app indicates acceptance of the updated terms."
            ])
        }
    }
    
    private var refundContent: some View {
        VStack(alignment: .leading, spacing: 15) {
            policySection(title: "Payment Processing", content: [
                "Payments made through Clinic Flow are processed for clinic services such as consultations or laboratory services, where applicable."
            ])
            
            policySection(title: "Refund Eligibility", content: [
                "Refunds or rescheduling requests are subject to the clinic's operational policies and may depend on:",
                "•  Service type",
                "•  Appointment status",
                "•  Time of cancellation"
            ])
            
            policySection(title: "Non-Refundable Cases", content: [
                "Completed services and missed appointments may not be eligible for refunds unless stated otherwise by the clinic."
            ])
            
            policySection(title: "Refund Process", content: [
                "Eligible refunds will be processed according to clinic guidelines. Users are advised to contact the clinic directly for refund-related inquiries."
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
