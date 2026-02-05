//
//  MapView.swift
//  ClinicFlow
//
//  Created by Ilmee De Silva on 2026-02-01.
//

import SwiftUI

struct ClinicMapView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {

                    // MAP CONTAINER
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemGray6))
                            .frame(height: 300)

                        // Simple layout
                        VStack(spacing: 20) {

                            HStack(spacing: 16) {
                                MapRoom(title: "Registration", icon: "person.crop.circle", color: .blue)
                                MapRoom(title: "Consultation", icon: "stethoscope", color: .green)
                            }

                            HStack(spacing: 16) {
                                MapRoom(title: "Laboratory", icon: "flask", color: .purple)
                                MapRoom(title: "Pharmacy", icon: "pills", color: .orange)
                            }
                        }

                        // YOU ARE HERE
                        VStack {
                            Spacer()
                            HStack {
                                Image(systemName: "location.fill")
                                    .foregroundColor(.blue)
                                Text("You are here")
                                    .font(.caption)
                            }
                            .padding(8)
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                            .padding(.bottom, 16)
                        }
                    }

                    // DEPARTMENT LIST
                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color(.systemGray5))
                                        .frame(height: 300)
                                        .overlay(Text("Clinic Map Placeholder"))

                                    ServiceCard(name: "Registration", icon: "person.crop.circle")
                                    ServiceCard(name: "Consultation", icon: "stethoscope")
                                    ServiceCard(name: "Laboratory", icon: "flask")
                                    ServiceCard(name: "Pharmacy", icon: "pills")
                                }
                                .padding()
                            }
                            .navigationTitle("Clinic Map")
        }
    }
}

struct MapRoom: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.title2)

            Text(title)
                .font(.footnote)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, minHeight: 90)
        .background(color.opacity(0.15))
        .cornerRadius(16)
    }
}

struct DepartmentRow: View {
    let name: String
    let room: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.title3)

            VStack(alignment: .leading) {
                Text(name)
                    .fontWeight(.medium)
                Text(room)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 3)
    }
}

