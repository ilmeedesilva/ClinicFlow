//
//  SplashView.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-05.
//

import SwiftUI

struct SplashView: View {
    @State private var goHome = false

    var body: some View {
        if goHome {
            MainTabView()
        } else {
            VStack(spacing: 16) {
                Image(systemName: "cross.case.fill")
                    .font(.system(size: 60))

                Text("Clinic Flow")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Smart Clinic Navigation")
                    .font(.caption)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    goHome = true
                }
            }
        }
    }
}
