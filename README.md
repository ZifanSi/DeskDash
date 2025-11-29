# DeskDash – McMaster Study Spot Finder
![DeskDash Logo](assets/images/deskdash_logo.png)

DeskDash is a mobile-first Flutter app that helps McMaster students quickly find a place to study on campus.

The app focuses on real student decisions:

> “Do I have a seat nearby, is it quiet enough, is there food close, and when is my next bus?”

All data in this prototype is **mocked**, but the flows are designed to feel like a real production app.

---

## 0. Screenshots



Home screen – study cards + food + buses:

![DeskDash Home – Discover](assets/images/demo1.png)

Place details – comfort snapshot + reviews:

![DeskDash Place Details](assets/images/demo2.png)

---

## 1. Core Features

### 1.1 Study place discovery

- Vertical list of **study cards** (Mills, Thode, MUSC, etc.).
- Each card shows:
  - Name and building (e.g., “Mills Library – 4th Floor”)
  - Rating
  - Tags (e.g., `#Quiet`, `#Outlets`, `#Group-friendly`)
  - Mini **Noise**, **Seats free**, and **Food** bars (capacity-style progress bars).
- Cards are consistent across:
  - **Discover**
  - **Favorites**
  - **Visited**

### 1.2 Search & filter

- **Search bar**:
  - Type a building or name (`"Mills"`, `"Thode"`, `"MUSC"`).
- **Filter chips**:
  - `Quiet`, `Group-friendly`, `Near food`, `Outlets`, `Indoor`, `Outdoor`.
- Filters and search apply **live** to the list.

### 1.3 Place details

For each study place:

- Large hero card (image + name + building + rating).
- Description and tags.
- **Live comfort snapshot (mock data)**:
  - `Seats free` – e.g., `40 / 180`
  - `Food spots open` – e.g., `1 / 2`
  - `Quietness` – e.g., `80% quiet`
- Actions:
  - **Save to favorites / Remove from favorites**
  - **Mark visited / Mark unvisited**
- Reviews:
  - List of short student-style reviews.
  - **Write a review** bottom sheet to add new comments.

### 1.4 Food nearby (additional function)

- Compact **“Food nearby”** panel on the home screen.
- Shows a scrollable list of food options (E-Café, La Piazza, Phoenix, etc.) with:
  - Image, name
  - Rating stars
  - Short quote
  - Price range
- A small “Location API / Google Maps API” label is used to signal the idea:
  - Real app: use current location → closest food places on/near campus.
  - This prototype: uses **mock data only**.
- Tapping a row opens the restaurant/menu URL in the browser via `url_launcher`.

### 1.5 Buses in next hour (additional function)

- **“Buses in next hour”** panel near the top of the home screen.
- Shows upcoming HSR-style routes used by McMaster students, such as:
  - `51 University`
  - `5 Delaware`
- Each card includes:
  - Route code
  - Stop (e.g., `MUSC Loop`)
  - Destination (e.g., `To Downtown`)
  - Departure time and “`in X min`” label
- Designed to help students decide:

> “Do I stay and study for 15 minutes or head to the loop now?”

- Uses mock data; no live transit API calls.

### 1.6 Favorites & visited

- **Favorites**:
  - Tap heart icon on a card or the “Save to favorites” button on the details screen.
  - View all favourites in the **Favorites** tab.
- **Visited**:
  - Tap “Mark visited” on the details screen.
  - Shows a “Visited” badge on the study card.
  - View all visited places in the **Visited** tab.

---

## 2. Tech Stack

- **Framework:** Flutter 3.27.x (stable)  
- **Language:** Dart  
- **Platforms tested:**
  - Chrome (Flutter web)
  - Android emulator (Pixel-sized, 1080×2400)
  - Android APK on real device
- **State / data:**
  - Local **mock data** in Dart files (no backend).
- **Packages:**
  - [`url_launcher`](https://pub.dev/packages/url_launcher) – open food menu links in external browser.
- **Assets:**
  - App logo: `assets/images/deskdash_logo.png`  
  - Demo screenshots: `assets/images/demo1.png`, `assets/images/demo2.png`

Make sure `pubspec.yaml` includes these assets:

```yaml
flutter:
  assets:
    - assets/images/deskdash_logo.png
