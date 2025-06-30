//
//  UserProfile.swift
//  ToDoList
//
//  Created by Izamuddin Nasir on 30/06/2025.
//


import Foundation

struct UserProfile: Identifiable, Codable {
    var id: String // UID
    var email: String
    var name: String
    var createdAt: Date
}
