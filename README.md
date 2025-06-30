# 📱 ToDoList App – SwiftUI + Firebase

A simple ToDoList app built with SwiftUI and Firebase. Supports user login and stores tasks in Firestore per user.

## ✨ Features
- User authentication (login & sign up)
- Add, delete, and toggle tasks
- Tasks stored in Firestore by user ID
- Clean SwiftUI interface (MVVM structure)

## 🛠 Tech Stack
- SwiftUI
- Firebase Authentication
- Firebase Firestore
- MVVM Architecture

## 🔐 Firestore Rules (Recommended)
```plaintext
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /tasks/{taskId} {
      allow read, write: if request.auth != null &&
                         request.auth.uid == resource.data.userId;
    }
  }
}
