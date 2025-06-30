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
    @State private var name = ""
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color.orange, Color.pink],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            
            VStack(spacing: 20) {
                // Title
                Text(isRegistering ? "Register" : "Login")
                    .font(.system(.largeTitle, design: .monospaced))
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                
                // Card style background
                VStack(spacing: 16) {
                    if isRegistering {
                        TextField("Name", text: $name)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .autocapitalization(.words)
                    }
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    if let error = authVM.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                    
                    Button(action: {
                        if isRegistering {
                            authVM.signUp(email: email, password: password, name: name)
                        } else {
                            authVM.signIn(email: email, password: password)
                        }
                    }) {
                        Text(isRegistering ? "Sign Up" : "Log In")
                            .font(.system(.headline, design: .monospaced))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.9))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        isRegistering.toggle()
                    }) {
                        Text(isRegistering ? "Already have an account? Log In" : "Don't have an account? Sign Up")
                            .font(.system(size: 12, design: .monospaced))
                            .foregroundColor(.gray)
                            .padding(.top, 4)
                    }
                    
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.horizontal, 30)
            }
            .padding()
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}

