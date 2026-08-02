# FlowFiles Architecture

## Architecture

FlowFiles follows Clean Architecture.

lib/

app/
- Dependency Injection
- App Configuration

core/
- Enums
- Utilities
- Shared Widgets
- Constants

features/

explorer/
- data/
- domain/
- presentation/

future/
- cloud/
- settings/
- favorites/
- search/

## Layers

Presentation
↓
Use Cases
↓
Repository
↓
Data Source
↓
File System

## Design Principles

- Single Responsibility
- Dependency Inversion
- Platform Independent
- Testable
- Modular
- Feature First

## Supported Platforms

- Windows
- Linux
- Android
- iOS

Future

- macOS
- Web (limited)
