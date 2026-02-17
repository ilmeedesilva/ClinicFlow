//
//  AppColors.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-16.
//

import SwiftUI

extension Color {
    static let primaryButton = Color(hex: "#0B5566")
    static let inputStroke = Color(hex: "#2D6876")
    static let startingBox = Color(hex: "CFE0CD")
    static let headerColor = Color(hex: "#2D6876")
    static let homeBox1 = Color(hex: "#E2EAFF")
    static let homeBox2 = Color(hex: "#EDFCF2")
    static let homeBox3 = Color(hex: "#FEF6EE")
    static let homeBox4 = Color(hex: "#FDCEC9")
    static let specialtyBorder = Color(hex: "#68B2A1")
    static let lightGrayBG = Color.gray.opacity(0.08)
    static let disabledGray = Color.gray.opacity(0.2)
    static let successBackround = Color(hex: "#68B2A1")
}

// Hex color initializer
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255,
                           (int >> 8) * 17,
                           (int >> 4 & 0xF) * 17,
                           (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255,
                           int >> 16,
                           int >> 8 & 0xFF,
                           int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24,
                           int >> 16 & 0xFF,
                           int >> 8 & 0xFF,
                           int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
