//
//  TaskViewModel.swift
//  ToDoList
//
//  Created by Izamuddin Nasir on 30/06/2025.
//


import Foundation
import FirebaseFirestore
import FirebaseAuth

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    private let db = Firestore.firestore()

    func fetchTasks() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        db.collection("tasks")
            .whereField("userId", isEqualTo: userId)
            .order(by: "createdAt", descending: false)
            .addSnapshotListener { snapshot, error in
                if let snapshot = snapshot {
                    self.tasks = snapshot.documents.compactMap { doc -> Task? in
                        try? doc.data(as: Task.self)
                    }
                }
            }
    }

    func addTask(title: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        let newTask = Task(title: title, isDone: false, userId: userId, createdAt: Date())
        do {
            _ = try db.collection("tasks").addDocument(from: newTask)
        } catch {
            print("Error adding task: \(error)")
        }
    }

    func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            if let id = tasks[index].id {
                db.collection("tasks").document(id).delete()
            }
        }
    }

    func toggleTask(_ task: Task) {
        guard let id = task.id else { return }
        db.collection("tasks").document(id).updateData(["isDone": !task.isDone])
    }
}
