//
//  ProfileView.swift
//  ToDoList
//
//  Created by Izamuddin Nasir on 01/07/2025.
//


import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        VStack(spacing: 20) {
            if let profile = authVM.userProfile {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding(.top)

                Text(profile.name)
                    .font(.title)
                    .bold()

                Text(profile.email)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Spacer()

                Button(action: {
                    authVM.signOut()
                }) {
                    Text("Log Out")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding()
            } else {
                ProgressView()
            }
        }
        .padding()
    }
}
