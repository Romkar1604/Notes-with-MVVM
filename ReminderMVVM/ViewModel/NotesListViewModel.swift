//
//  NotesListViewModel.swift
//  ReminderMVVM
//
//  Created by Omkar Ranawade on 2/19/26.
//

import Foundation


protocol NotesListViewModelProtocol: AnyObject {
    var numberOfRows: Int { get }
    func note(at index: Int) -> Note
    func update(note: Note)
    func addNote(title: String, content: String)
    var notes: [Note] { get }
    var onNotesChanged: (() -> Void)? { get set }
}


final class NotesListViewModel: NotesListViewModelProtocol{

    private(set) var notes: [Note] = [
        Note(id: UUID(), title: "New Note", content: "Tap to write")
    ]

    //closure initiate
    var onNotesChanged: (() -> Void)?

    var numberOfRows: Int {
        notes.count
    }   

    func note(at index: Int) -> Note {
        guard notes.indices.contains(index) else {
            return Note(id: UUID(), title: "", content: "")
        }
        return notes[index]
    }

    //to update a note
    func update(note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index] = note
            
            //closure call
            onNotesChanged?()
        }
    }
    
    //to add a note
    func addNote(title: String, content: String) {
        let new = Note(id: UUID(), title: title, content: content)
        notes.append(new)
        
        //closure call
        onNotesChanged?()
    }
}
