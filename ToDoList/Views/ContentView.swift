//
//  ContentView.swift
//  ToDoList
//
//  Created by Izamuddin Nasir on 30/06/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        if authVM.user != nil {
            TaskListView()
        } else {
            LoginView()
        }
    }
}

