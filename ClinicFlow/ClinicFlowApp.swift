//
//  ClinicFlowApp.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-01.
//

import SwiftUI

@main
struct ClinicFlowApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
