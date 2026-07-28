# FlowFiles Architecture

## Project Architecture

FlowFiles follows Clean Architecture with feature-first organization.

lib/
├── app/
├── core/
├── features/
│   ├── explorer/
│   ├── clipboard/
│   ├── search/
│   ├── preview/
│   ├── settings/
│   ├── cloud/
│   └── ai/
└── main.dart

---

## Layer Structure

Each feature follows:

feature/
├── data/
├── domain/
└── presentation/

### data
- Models
- Data Sources
- Repository Implementations

### domain
- Entities
- Repositories
- Use Cases

### presentation
- Controllers
- State
- Widgets
- Pages

---

## State Management

Current approach:

ChangeNotifier

Controllers own state.

Widgets observe controllers.

ServiceLocator provides dependency injection.

---

## Dependency Rules

Presentation
↓

Domain
↓

Data

Never reverse this dependency.

---

## Controllers

ExplorerController

Responsibilities

- Open directory
- Search
- Sort
- Refresh
- Navigation

SelectionController

Responsibilities

- Single selection
- Multi-selection
- Ctrl+A
- ESC
- Selection count

Future Controllers

ClipboardController

SearchController

PreviewController

SettingsController

CloudController

AIController

---

## Platform Support

Primary

Windows

Secondary

Android

macOS

iOS

Linux

Not Supported

---

## Coding Rules

- Complete file replacement only
- No partial snippets
- flutter analyze must be clean
- dart format before every commit
- Small focused commits
- One feature per commit

---

## UI Principles

- Material 3
- Responsive
- Desktop-first
- Mobile compatible

---

## Future Architecture

Explorer

↓

Selection

↓

Clipboard

↓

Preview

↓

Cloud

↓

AI

Each module must remain independent.

