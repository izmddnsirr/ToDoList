//
//  AuthViewModel.swift
//  ToDoList
//
//  Created by Izamuddin Nasir on 30/06/2025.
//


import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    init() {
        checkUser()
    }

    func checkUser() {
        if let currentUser = Auth.auth().currentUser {
            self.user = User(uid: currentUser.uid, email: currentUser.email)
        }
    }

    func signIn(email: String, password: String) {
        isLoading = true
        errorMessage = nil
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else if let result = result {
                    self.user = User(uid: result.user.uid, email: result.user.email)
                }
            }
        }
    }

    func signUp(email: String, password: String) {
        isLoading = true
        errorMessage = nil
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else if let result = result {
                    self.user = User(uid: result.user.uid, email: result.user.email)
                }
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
