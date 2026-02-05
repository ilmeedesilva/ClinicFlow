import SwiftUI
import Observation

@Observable
final class VisitStatusViewModel {
    // High-level visit progress (0...1)
    var overallProgress: Double = 0.25

    // Queue
    var currentService: String = "Registration"
    var nowServing: String = "A-08"
    var yourToken: String = "A-12"
    var estimatedWaitMinutes: Int = 10

    // Consultation
    var consultationRoom: String = "Room 03"
    var consultationInProgress: Bool = false

    // Laboratory
    var labToken: String = "L-05"
    var labEstimatedWaitMinutes: Int = 15

    // Pharmacy
    var prescriptionStatus: String = "Preparing"
    var pickupETAminutes: Int = 5

    // Simple helpers to mutate state (could be wired to network later)
    func advanceQueue() {
        // Simulate queue advancement
        nowServing = "A-09"
        estimatedWaitMinutes = max(0, estimatedWaitMinutes - 2)
        if yourToken == nowServing { consultationInProgress = true }
        recalcProgress()
    }

    func startConsultation() {
        consultationInProgress = true
        currentService = "Consultation"
        recalcProgress()
    }

    func completeConsultation() {
        consultationInProgress = false
        currentService = "Laboratory"
        recalcProgress()
    }

    func updateLab(wait delta: Int) {
        labEstimatedWaitMinutes = max(0, labEstimatedWaitMinutes + delta)
        recalcProgress()
    }

    func updatePharmacy(status: String, eta: Int) {
        prescriptionStatus = status
        pickupETAminutes = max(0, eta)
        recalcProgress()
    }

    private func recalcProgress() {
        // Naive staged progress: Registration, Consultation, Lab, Pharmacy
        var progress: Double = 0
        if currentService == "Registration" { progress = 0.25 }
        else if currentService == "Consultation" { progress = consultationInProgress ? 0.5 : 0.35 }
        else if currentService == "Laboratory" { progress = 0.7 }
        else if currentService == "Pharmacy" { progress = 0.9 }
        overallProgress = progress
    }
}
