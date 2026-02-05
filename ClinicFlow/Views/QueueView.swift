//
//  QueueView.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-01.
//

//import SwiftUI
//
//struct QueueView: View {
//    @State private var pulse = false
//
//    var body: some View {
//        VStack(spacing: 32) {
//
//            VStack(spacing: 8) {
//                Text("Your Token")
//                    .foregroundColor(.secondary)
//
//                Text("A12")
//                    .font(.system(size: 52, weight: .bold))
//                    .scaleEffect(pulse ? 1.05 : 1)
//                    .animation(
//                        .easeInOut(duration: 1)
//                            .repeatForever(autoreverses: true),
//                        value: pulse
//                    )
//            }
//
//            InfoCard(title: "Estimated Waiting Time",
//                     subtitle: "Approximately 15 minutes",
//                     icon: "timer")
//
//            InfoCard(title: "Current Status",
//                     subtitle: "Waiting for consultation",
//                     icon: "hourglass")
//
//            Spacer()
//        }
//        .padding()
//        .navigationTitle("Queue Status")
//        .onAppear { pulse = true }
//    }
//}
//
