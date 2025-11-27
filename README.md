# 📝 TODO App

A beautiful and feature-rich Flutter TODO application with date-based task tracking, statistics, and intuitive swipe gestures.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

## ✨ Features

### 🎯 Core Functionality
- **Create Tasks**: Add new tasks with automatic timestamp
- **Edit Tasks**: Swipe left to edit any task
- **Delete Tasks**: Swipe right to remove tasks
- **Mark Complete**: Check off completed tasks with visual strikethrough
- **Persistent Storage**: All tasks saved locally using Hive database

### 📅 Date-Based Management
- **Creation Timestamps**: Each task stores its creation date and time
- **Smart Date Display**: 
  - "Today HH:MM" for tasks created today
  - "Yesterday" for tasks created yesterday
  - "X days ago" for recent tasks
  - Full date (DD/MM/YYYY) for older tasks
- **Sorting Options**:
  - Sort by Newest (default)
  - Sort by Oldest
  - Automatic sorting on task creation

### 📊 Statistics Dashboard
- **Total Tasks**: View count of all tasks
- **Completed Tasks**: Track your progress
- **Pending Tasks**: See what's left to do
- Real-time statistics in the drawer menu

### 🎨 User Interface
- **Modern Material Design 3**: Clean and intuitive interface
- **Blue Color Scheme**: Consistent and professional look
- **Swipe Gestures**: 
  - Swipe **LEFT** (→) for **Edit** (Green button)
  - Swipe **RIGHT** (←) for **Delete** (Red button)
- **Empty State**: Helpful message when no tasks exist
- **Responsive Layout**: Works on all screen sizes

### 🛠️ Advanced Features
- **Clear Completed Tasks**: Bulk remove all finished tasks
- **Clear All Tasks**: Delete everything with confirmation dialog
- **Refresh Button**: Manual refresh in app bar
- **Task Migration**: Automatically updates old data format
- **About Section**: App information and version

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.10.1 or higher)
- Dart SDK (3.10.1 or higher)
- Android Studio / VS Code with Flutter extensions
- Android Emulator / iOS Simulator / Physical Device

## 📦 Dependencies

```yaml
dependencies:
  flutter_slidable: ^3.1.1    # Swipe gesture functionality
  hive: ^2.2.3                # Local database
  hive_flutter: ^1.1.0        # Hive Flutter integration
  hive_generator: ^2.0.1      # Code generation for Hive

dev_dependencies:
  build_runner: ^2.4.14       # Code generation tool
  flutter_lints: ^6.0.0       # Linting rules
```


## 💡 Usage Guide

### Adding a Task
1. Tap the **+** (Floating Action Button) at the bottom right
2. Enter your task name in the dialog
3. Tap **Save** to add the task

### Editing a Task
1. **Swipe LEFT** (→) on any task
2. Tap the green **Edit** button
3. Modify the task name
4. Tap **Save** to update

### Deleting a Task
1. **Swipe RIGHT** (←) on any task
2. Tap the red **Delete** button
3. Task is immediately removed

### Marking Complete
1. Tap the **checkbox** on any task
2. Completed tasks show with strikethrough text

### Accessing Features
1. Tap the **☰** (hamburger menu) at the top left
2. View statistics, change sorting, or clear tasks

### Sorting Tasks
1. Open the drawer menu
2. Select **"Sort by Newest"** or **"Sort by Oldest"**
3. Tasks automatically rearrange

## 🔧 Technical Details

### Data Storage
- **Database**: Hive (NoSQL local database)
- **Storage Location**: Device application directory
- **Data Format**: `[taskName, isCompleted, createdDate]`
- **Persistence**: Automatic on every change

### Data Migration
The app automatically migrates old data format to include creation dates:
```dart
// Old format: [taskName, isCompleted]
// New format: [taskName, isCompleted, createdDate]
```

### State Management
- **Pattern**: StatefulWidget with setState
- **Scope**: Local state management
- **Reactivity**: Immediate UI updates on data changes



## 👨‍💻 Author

**Ayan Pal**
- GitHub: [@ayanpal01](https://github.com/ayanpal01)


---

Made with ❤️ using Flutter
