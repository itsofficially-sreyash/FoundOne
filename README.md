# 📱 FoundOne

> **Organize lost, found, and resale items on campus — smarter than WhatsApp groups.**  
> A real-time Flutter + Firebase app with clean architecture and OTP-based user verification.

---

## 🧩 Overview

**FoundOne** is a campus utility app that helps students manage lost & found items and resale listings in a structured, searchable, and trustworthy environment — unlike cluttered WhatsApp groups.

---

## ✨ Features

- 🔐 **Custom Auth Flow** (Name + Phone + OTP via Firebase Auth)
- 🏷️ **Create Categorized Posts** (Lost, Found, Sale)
- 🧠 **Real-Time Feed** (Firestore Stream)
- 📸 **Image Uploads** (Firebase Storage)
- ✅ **Post Resolution** ("Mark as Found/Sold")
- 🔎 **Keyword Search Bar**
- 🧱 **Clean Architecture** (Domain-Driven, Scalable)
- ⚡ **Provider State Management**

---

## 🧪 Tech Stack

- **Flutter 3.x**
- **Firebase Auth** (Phone OTP)
- **Cloud Firestore**
- **Firebase Storage**
- **Provider**
- **Clean Architecture** (3-layer: Presentation / Domain / Data)

---

## 📁 Folder Structure (Clean Architecture)

```

lib/
├── presentation/
│   └── screens/     # All UI screens (auth, home, post)
│   └── providers/   # All UI-facing logic and state
├── domain/
│   └── entities/    # Core business entities (User, Post)
│   └── usecases/    # Application-level actions
│   └── repositories/ # Abstract contracts
├── data/
│   └── datasources/ # Firebase Auth & Firestore integration
│   └── models/      # DTOs (PostModel, UserModel)
│   └── repositories/ # Impl of domain contracts

````

## 🧑‍💻 Getting Started

### 🚀 Firebase Setup

1. Create a Firebase project
2. Enable:
   - Phone Authentication
   - Cloud Firestore
   - Firebase Storage
3. Download `google-services.json` and add it to `android/app/`

### 🔧 Run Locally

```bash
git clone https://github.com/itsofficially-sreyash/foundone.git
cd foundone
flutter pub get
flutter run
````

---

## 📌 Future Roadmap

* 🧑‍💬 In-app Chat between finder & owner
* 🔔 Push Notifications for matched/resolved items
* 🌐 Multi-campus or institution support
* 🔍 Advanced filters (location, category, date)
* 💬 Feedback/Support ticket system

---

## 🙌 Contribution

Pull requests are welcome! For major changes, please open an issue first.

If you’re a student or open-source contributor and want to collaborate, message me directly.
