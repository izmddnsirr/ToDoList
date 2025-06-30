//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Izamuddin Nasir on 30/06/2025.
//

import SwiftUI
import Firebase

@main
struct ToDoListApp: App {
    @StateObject var authVM = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authVM)
        }
    }
}

