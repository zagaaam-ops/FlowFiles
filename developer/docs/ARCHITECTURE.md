# FlowFiles

# System Architecture

Version: 0.1

---

# Architecture Overview

FlowFiles follows **Clean Architecture** with feature-based organization.

The application is divided into independent modules to maximize maintainability, scalability, and testability.

```
                Presentation
                       │
                       ▼
                 Application
                       │
                       ▼
                    Domain
                       │
                       ▼
                      Data
                       │
                       ▼
              Platform Services
                       │
                       ▼
              Native Operating System
```

---

# Folder Structure

```
lib/

app/

core/

shared/

platform/

features/

    explorer/

    organizer/

    search/

    favorites/

    settings/

services/
```

---

# Layers

## Presentation

Responsible for:

- UI
- Widgets
- Pages
- State Management
- User Interaction

Uses:

- Flutter
- Riverpod

Never directly accesses the file system.

---

## Application

Responsible for:

- Business orchestration
- Dependency Injection
- Routing
- Global services

---

## Domain

Contains:

- Entities
- Repository interfaces
- Use Cases

Rules:

- No Flutter imports
- No dart:io
- Platform independent

---

## Data

Responsible for:

- Repository implementations
- Mappers
- Models
- Data sources

---

## Platform

Provides:

- File System
- Clipboard
- Permissions
- Drag & Drop
- Native integrations

Each operating system has its own implementation.

---

# Feature Modules

## Explorer

Responsibilities

- Browse folders
- Read files
- Navigation
- Sorting
- Filtering

---

## Organizer

Responsibilities

- Selection
- Multi-selection
- Organizer Mode
- Drag & Drop
- Move Queue

---

## Search

Responsibilities

- Instant Search
- Recursive Search
- Filters

---

## Favorites

Responsibilities

- Pinned folders
- Recent folders
- Quick access

---

## Settings

Responsibilities

- Theme
- Language
- Preferences

---

# Core Services

- Logger
- Dialog Service
- Navigation Service
- Snackbar Service

---

# Design Principles

- SOLID
- Clean Architecture
- DRY
- KISS
- Composition over inheritance

---

# Dependency Flow

```
Presentation

↓

Application

↓

Domain

↓

Data

↓

Platform
```

Dependencies always point downward.

Lower layers never depend on upper layers.

---

# State Management

Riverpod

Reasons

- Compile-time safety
- Testability
- Performance
- Scalability

---

# Testing Strategy

Unit Tests

↓

Widget Tests

↓

Integration Tests

↓

End-to-End Testing

---

# Future Expansion

The architecture supports future modules including:

- Cloud Sync
- AI Organization
- Duplicate Detection
- Plugins
- Extensions
- Multiple Windows
- Batch Processing

---

Version

0.1
