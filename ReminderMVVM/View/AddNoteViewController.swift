//
//  AddNoteViewController.swift
//  ReminderMVVM
//
//  Created by Omkar Ranawade on 2/19/26.
//

import UIKit

final class AddNoteViewController: UIViewController {

    // MARK: - Properties
    var titleField: UITextField?
    var contentView: UITextView?
    let saveButton = UIButton(type: .system)

    private let listViewModel: NotesListViewModelProtocol

    init(listViewModel: NotesListViewModelProtocol) {
        self.listViewModel = listViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "New Note"
        view.backgroundColor = .black

        setupUI()
        setupSaveButton()
    }

    // MARK: - Setup UI
    private func setupUI() {

        titleField = UITextField()
        titleField?.borderStyle = .roundedRect
        titleField?.placeholder = "Title"
        titleField?.translatesAutoresizingMaskIntoConstraints = false

        contentView = UITextView()
        contentView?.layer.borderWidth = 1
        contentView?.layer.cornerRadius = 10
        contentView?.translatesAutoresizingMaskIntoConstraints = false


        guard let titleField = titleField else { return }
        guard let contentView = contentView else { return }

        view.addSubview(titleField)
        view.addSubview(contentView)

        //Constraints
        NSLayoutConstraint.activate([
            titleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleField.heightAnchor.constraint(equalToConstant: 44),

            contentView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 12),
            contentView.leadingAnchor.constraint(equalTo: titleField.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: titleField.trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    // MARK: - Save Button
    private func setupSaveButton() {

        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .orange
        saveButton.layer.cornerRadius = 10
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)

        view.addSubview(saveButton)

        guard let contentView = contentView else { return }

        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }


    // MARK: - Actions
    @objc private func saveTapped() {

        let title = titleField?.text ?? ""
        let content = contentView?.text ?? ""

        listViewModel.addNote(title: title, content: content)
        navigationController?.popViewController(animated: true)
    }
}
