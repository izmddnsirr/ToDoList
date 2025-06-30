//
//  ContentView.swift
//  ToDoList
//
//  Created by Izamuddin Nasir on 30/06/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        Group {
            if authVM.user != nil {
                MainTabView()
            } else {
                LoginView()
            }
        }
        .environment(\.font, .system(.body, design: .monospaced)) // ✅ apply font globally
        .preferredColorScheme(isDarkMode ? .dark : .light) // optional
    }
}




