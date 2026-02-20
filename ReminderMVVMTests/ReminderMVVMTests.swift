//
//  ReminderMVVMTests.swift
//  ReminderMVVMTests
//
//  Created by Omkar Ranawade on 2/19/26.
//

import XCTest
@testable import ReminderMVVM

final class ReminderMVVMTests: XCTestCase {

    private var listVM: NotesListViewModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        listVM = NotesListViewModel()
        
        // Add initial testing notes
        listVM?.addNote(title: "First Note", content: "Hello world")
        listVM?.addNote(title: "Second Note", content: "Do homework")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Test Add Note
    func testNoteAddVM() {
        guard let listVM else { return }

        let oldCount = listVM.notes.count

        listVM.addNote(title: "New Test Note", content: "Content here")

        let newList = listVM.notes

        XCTAssertEqual(newList.count, oldCount + 1)
        XCTAssertEqual(newList.last?.title, "New Test Note")
        XCTAssertEqual(newList.last?.content, "Content here")
    }

    // MARK: - Test Edit Note
    func testNoteEditVM() {
        guard let listVM else { return }

        // Editing the second actual note (index 1)
        var note = listVM.notes[1]

        XCTAssertEqual(note.title, "First Note")
        XCTAssertEqual(note.content, "Hello world")

        note.title = "Updated Title"
        note.content = "Updated Content"

        listVM.update(note: note)

        let updated = listVM.notes[1]

        XCTAssertEqual(updated.title, "Updated Title")
        XCTAssertEqual(updated.content, "Updated Content")
    }

    // MARK: - Test List ViewModel
    func testNoteListVM() {
        guard let listVM else { return }

        XCTAssertEqual(listVM.notes.count, 3)

        let defaultNote = listVM.notes[0]
        XCTAssertEqual(defaultNote.title, "New Note")
        XCTAssertEqual(defaultNote.content, "Tap to write")

        let first = listVM.notes[1]
        XCTAssertEqual(first.title, "First Note")
        XCTAssertEqual(first.content, "Hello world")

        let second = listVM.notes[2]
        XCTAssertEqual(second.title, "Second Note")
        XCTAssertEqual(second.content, "Do homework")
    }
    
    func test_numberOfRows() {
        guard let listVM else { return }
        XCTAssertEqual(listVM.numberOfRows, listVM.notes.count)
    }

    func test_noteAtInvalidIndex() {
        guard let listVM else { return }
        let note = listVM.note(at: 999)
        XCTAssertEqual(note.title, "")
        XCTAssertEqual(note.content, "")
    }

    func test_updateInvalidNoteDoesNothing() {
        guard let listVM else { return }
        let before = listVM.notes.count
        let badNote = Note(id: UUID(), title: "Random", content: "Fail")
        listVM.update(note: badNote)
        XCTAssertEqual(listVM.notes.count, before)
    }

    func test_onNotesChangedCalledOnAdd() {
        guard let listVM else { return }

        let exp = expectation(description: "Closure called")

        listVM.onNotesChanged = { exp.fulfill() }

        listVM.addNote(title: "A", content: "B")

        wait(for: [exp], timeout: 1.0)
    }
}
