//
//  NoteDetailViewModel.swift
//  ReminderMVVM
//
//  Created by Omkar Ranawade on 2/19/26.
//

import Foundation

protocol NoteDetailViewModelProtocol: AnyObject {
    func save(title: String, content: String)
    var titleText: String { get }
    var contentText: String { get }
    var note: Note { get }
}

final class NoteDetailViewModel: NoteDetailViewModelProtocol{

    private let listViewModel: NotesListViewModelProtocol
    private(set) var note: Note

    init(note: Note, listViewModel: NotesListViewModelProtocol) {
        self.note = note
        self.listViewModel = listViewModel
    }

    var titleText: String { note.title ?? "" }
    var contentText: String { note.content ?? "" }

    func save(title: String, content: String) {
        note.title = title
        note.content = content
        listViewModel.update(note: note)
    }
}
