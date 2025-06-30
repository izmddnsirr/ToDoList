//
//  SettingsView.swift
//  ToDoList
//
//  Created by Izamuddin Nasir on 01/07/2025.
//


import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = true

    var body: some View {
        Form {
            Section(header: Text("Appearance")) {
                Toggle("Dark Mode", isOn: $isDarkMode)
            }

            Section(header: Text("About")) {
                HStack {
                    Text("App Version")
                    Spacer()
                    Text("1.0.0")
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Settings")
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}
