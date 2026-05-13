You are a senior Flutter engineer.

Build a production-ready Flutter MVP app called **Momentree** based on the following strict specification.

DO NOT add features outside the spec.

---

# 1. PRODUCT DEFINITION

Momentree is an offline self-discipline app with:

* Streak tracking system
* Growth scoring system
* Tree growth visualization system
* Craving (urge) interruption system
* Fully local storage only (NO backend)

---

# 2. TECH STACK

* Flutter 3.x
* GetX (state management)
* sqflite (main storage)
* shared_preferences (light state)
* flutter_local_notifications (local reminders)

---

# 3. CORE DATA MODEL

Record:

* date
* streak
* momentum
* success (bool)

State:

* current streak
* current momentum
* free recovery count
* theme style

---

# 4. CORE RULES (DO NOT CHANGE)

## 4.1 Growth rules

On success check-in:

* +10 momentum
* streak +1

If streak % 3 == 0:

* +3 bonus momentum

On failure:

* -15 momentum
* streak = 0
* trigger withered state

---

## 4.2 Craving system

When user enters craving mode:

* Start countdown (default 60 seconds)

Outcomes:

* success → +5 momentum
* fail → -15 momentum + streak reset
* exit early → no change

---

## 4.3 Recovery system

* 1 free recovery per day (reset at 00:00)
* After free used → show rewarded ad recovery option
* Recovery restores streak and removes withered state
* No momentum change on recovery

---

# 5. TREE SYSTEM

Tree visual state depends ONLY on momentum:

* 0–20: seed 🌱
* 20–50: sprout 🌿
* 50–100: tree 🌳
* 100+: forest 🌲

If withered:

* darkened tree + subtle leaf drop effect

Tree state is NOT stored, only derived from momentum.

---

# 6. UI ARCHITECTURE

## Home Page

* Day counter (streak)
* Growth value
* Tree visualization (center)
* Buttons:

    * Success check-in
    * Failure check-in
    * Craving entry button
* Banner ad at bottom only

---

## Craving Page

* 60 second countdown
* motivational text
* buttons:

    * I held strong
    * I gave in

---

## Settings Page

Theme selection:

* Forest Night
* Morning Field
* Voltage

---

# 7. THEME SYSTEM (CRITICAL FEATURE)

Implement 3 visual themes:

## 7.1 Forest Night

* dark green background
* glassmorphism cards
* emerald glow accents
* calm emotional tone

## 7.2 Morning Field

* white / warm background
* soft shadows
* orange accent color
* gentle emotional tone

## 7.3 Voltage

* dark navy background
* neon cyan/purple glow
* high contrast UI
* energetic tone

Theme must dynamically change entire MaterialApp.

---

# 8. STORAGE

Use:

* sqflite → records, streak, momentum history
* shared_preferences → theme, free recovery count, flags

---

# 9. STATE MANAGEMENT

Use GetX only.

Create controllers:

* HomeController
* ThemeController
* CravingController

---

# 10. UI PRINCIPLES

* Minimal UI
* Single focus per screen
* Strong visual feedback on state change
* No authentication
* No backend
* No extra pages

---

# 11. OUTPUT REQUIREMENT

Generate a fully working Flutter project with:

* runnable main.dart
* complete navigation
* working state logic
* theme switching
* basic tree UI placeholder (can use icons/images)
* clean architecture

DO NOT:

* add backend
* add login
* add unnecessary complexity
* split into microservices

---

# GOAL

A fully working MVP app that demonstrates:

Self-discipline system + emotional UI + behavioral reinforcement loop.

---
