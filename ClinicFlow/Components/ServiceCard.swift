//
//  ServiceCard.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-05.
//

import SwiftUI

struct ServiceCard: View {
    let name: String
    let icon: String

    var body: some View {
        VStack {
            Image(systemName: icon).font(.largeTitle)
            Text(name).font(.caption)
        }
        .frame(maxWidth: .infinity, minHeight: 80)
        .background(Color(.systemGray6))
        .cornerRadius(14)
    }
}
