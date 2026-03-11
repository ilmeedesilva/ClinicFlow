//
//  ClinicFlowApp.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-01.
//

import SwiftUI

@main
struct ClinicFlowApp: App {
    
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            
            if appState.isLoggedIn {
                MainTabView()
                    .environmentObject(appState)
            } else {
                NavigationStack {
                    StartView()
                }
                .environmentObject(appState)
            }
        }
    }
}
