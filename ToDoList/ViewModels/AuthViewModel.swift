//
//  AuthViewModel.swift
//  ToDoList
//
//  Created by Izamuddin Nasir on 30/06/2025.
//


import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var userProfile: UserProfile?

    init() {
        checkUser()
    }

    func checkUser() {
        if let currentUser = Auth.auth().currentUser {
            self.user = User(uid: currentUser.uid, email: currentUser.email)
            self.fetchUserProfile()
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
                    self.fetchUserProfile()
                }
            }
        }
    }

    func signUp(email: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                return
            }

            guard let user = result?.user else { return }

            let userProfile = UserProfile(
                id: user.uid,
                email: email,
                name: name,
                createdAt: Date()
            )

            do {
                try Firestore.firestore()
                    .collection("users")
                    .document(user.uid)
                    .setData(from: userProfile)
            } catch {
                print("❌ Gagal simpan user ke Firestore: \(error.localizedDescription)")
            }

            DispatchQueue.main.async {
                self.user = User(uid: user.uid, email: email)
                self.fetchUserProfile()
            }
        }
    }
    
    func fetchUserProfile() {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if let data = snapshot?.data() {
                do {
                    let profile = try Firestore.Decoder().decode(UserProfile.self, from: data)
                    DispatchQueue.main.async {
                        self.userProfile = profile
                    }
                } catch {
                    print("❌ Gagal decode user profile: \(error.localizedDescription)")
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
