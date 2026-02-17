//
//  ClinicFlowApp.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-01.
//

import SwiftUI

@main
struct ClinicFlowApp: App {
    
    @State private var isLoggedIn = true
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MainTabView()
                    .environmentObject(appState)
            } else {
                StartView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
