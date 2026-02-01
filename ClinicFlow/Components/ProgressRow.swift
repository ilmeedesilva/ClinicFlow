//
//  ProgressRow.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-01.
//

import SwiftUI

struct ProgressRow: View {
    let title: String
    let status: String
    let icon: String

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .foregroundColor(status == "Completed" ? .green : .blue)

            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(status)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}
