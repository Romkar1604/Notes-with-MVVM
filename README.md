# ReminderMVVM (iOS • Swift • MVVM)

A simple Notes / Reminders iOS app built using Swift, UIKit, and the MVVM pattern.  
Users can add notes and view details.  
**Note:** This project does **not** include a delete option for removing notes.

---

## Features

- MVVM architecture (Model → View → ViewModel)
- Add new notes
- Display list of notes
- View note details
- Clean folder structure (Model, View, ViewModel, Cell)
- Includes unit test and UI test setup

---

## Project Structure

ReminderMVVM/

 ├── Model/
 
 └── Note.swift
 
 ├── View/
 
 ├── NotesListViewController.swift
 
 ├── AddNoteViewController.swift
 
 └── NoteDetailViewController.swift
 
 ├── ViewModel/
 
  ├── NotesListViewModel.swift
  
  └── NoteDetailViewModel.swift
 
 ├── Cell/
     
  └── NoteTableViewCell.swift
 
 ├── AppDelegate.swift
 
 ├── SceneDelegate.swift
 
 ├── Tests/
 
 ├── UITests/

 ---

## Tech Stack

- Swift 5
- UIKit
- MVVM
- Storyboard + Programmatic UI
- XCTest (Unit & UI Tests)

---

## Missing Functionality

**Delete note option is not implemented.**  
Notes can only be added and viewed.

---

## How to Run

1. Download or clone the repository  
2. Open `ReminderMVVM.xcodeproj` in Xcode  
3. Run the app on Simulator or physical device  
4. Add and view notes

---

## Future Improvements

- Add delete functionality  
- Add edit functionality  
- Add persistence (UserDefaults / CoreData)  
- Add search feature  
- Improved UI

---

## Contributions

Pull requests and improvements are welcome.

##Screnshots

![Simulator Screen Recording - iPhone 17 Pro - 2026-02-20 at 14 59 33](https://github.com/user-attachments/assets/9079e4b9-51ab-4431-95e2-81ae537f4ea7)
