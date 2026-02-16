//
//  ClinicFlowApp.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-01.
//

import SwiftUI

@main
struct ClinicFlowApp: App {
    
    @State private var isLoggedIn = false
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                Text("Dashboard/Home Screen Coming Soon")
                    .font(.title)
            } else {
                StartView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
