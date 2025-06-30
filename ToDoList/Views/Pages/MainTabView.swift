//
//  MainTabView.swift
//  ToDoList
//
//  Created by Izamuddin Nasir on 01/07/2025.
//


import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            TaskListView()
                .tabItem {
                    Label("Tasks", systemImage: "checklist")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .background(Color.white)
    }
}
