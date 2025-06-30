//
//  TaskListView.swift
//  ToDoList
//
//  Created by Izamuddin Nasir on 30/06/2025.
//


import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject var taskVM = TaskViewModel()
    @State private var newTask = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Tugas baru...", text: $newTask)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        guard !newTask.isEmpty else { return }
                        taskVM.addTask(title: newTask)
                        newTask = ""
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }.padding()

                List {
                    ForEach(taskVM.tasks) { task in
                        HStack {
                            Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                                .onTapGesture {
                                    taskVM.toggleTask(task)
                                }
                            Text(task.title)
                                .strikethrough(task.isDone)
                                .foregroundColor(task.isDone ? .gray : .primary)
                        }
                    }
                    .onDelete(perform: taskVM.deleteTask)
                }
            }
            .navigationTitle("Senarai Tugasan")
            .toolbar {
                Button("Log Keluar") {
                    authVM.signOut()
                }
            }
        }
        .onAppear {
            taskVM.fetchTasks()
        }
    }
}
