//
//  LoginView.swift
//  ToDoList
//
//  Created by Izamuddin Nasir on 30/06/2025.
//


import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isRegistering = false

    var body: some View {
        VStack(spacing: 20) {
            Text(isRegistering ? "Daftar" : "Log Masuk")
                .font(.largeTitle)
                .bold()

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if let error = authVM.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            Button(action: {
                if isRegistering {
                    authVM.signUp(email: email, password: password)
                } else {
                    authVM.signIn(email: email, password: password)
                }
            }) {
                Text(isRegistering ? "Daftar" : "Log Masuk")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }

            Button(action: {
                isRegistering.toggle()
            }) {
                Text(isRegistering ? "Sudah ada akaun? Log Masuk" : "Belum ada akaun? Daftar")
                    .font(.footnote)
            }
        }
        .padding()
    }
}
