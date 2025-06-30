//
//  Task.swift
//  ToDoList
//
//  Created by Izamuddin Nasir on 30/06/2025.
//


import Foundation
import FirebaseFirestore

struct Task: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var isDone: Bool
    var userId: String
    var createdAt: Date
}
