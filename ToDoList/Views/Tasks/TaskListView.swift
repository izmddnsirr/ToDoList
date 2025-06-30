import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject var taskVM = TaskViewModel()
    @State private var newTask = ""
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                VStack(spacing: 16) {
                    if let profile = authVM.userProfile {
                        Text("Welcome back, \(profile.name)!")
                            .font(.system(.title2, design: .monospaced))
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .padding(.top)
                    }

                    // Input Field
                    HStack(spacing: 10) {
                        TextField("Add a new task...", text: $newTask)
                            .font(.system(.body, design: .monospaced))
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.secondarySystemBackground))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.2))
                            )
                            .disableAutocorrection(true)

                        Button(action: {
                            guard !newTask.isEmpty else { return }
                            withAnimation {
                                taskVM.addTask(title: newTask)
                            }
                            newTask = ""
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal)

                    // List with swipe-to-delete
                    List {
                        ForEach(taskVM.tasks) { task in
                            HStack {
                                Button {
                                    withAnimation {
                                        taskVM.toggleTask(task)
                                    }
                                } label: {
                                    Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                                        .font(.title2)
                                        .foregroundColor(task.isDone ? .green : .gray)
                                }

                                Text(task.title)
                                    .font(.system(.body, design: .monospaced))
                                    .foregroundColor(task.isDone ? .secondary : .primary)
                                    .strikethrough(task.isDone)
                                    .padding(.leading, 6)

                                Spacer()
                            }
                            .padding(.vertical, 8)
                            .listRowBackground(
                                colorScheme == .dark ?
                                    Color(.tertiarySystemFill) :
                                    Color.white
                            )
                        }
                        .onDelete(perform: taskVM.deleteTask)
                    }
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden) // Remove default background
                }
            }
            .navigationTitle("📝 My Task List")
            .font(.system(.body, design: .monospaced))
        }
        .onAppear {
            taskVM.fetchTasks()
        }
    }
}
