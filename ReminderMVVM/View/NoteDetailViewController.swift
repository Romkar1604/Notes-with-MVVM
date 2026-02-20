//
//  NoteDetailViewController.swift
//  ReminderMVVM
//
//  Created by Omkar Ranawade on 2/19/26.
//

import UIKit

final class NoteDetailViewController: UIViewController {

    // MARK: - Properties
    var titleField: UITextField?
    var contentView: UITextView?
    let saveButton = UIButton(type: .system)

    private let viewModel: NoteDetailViewModelProtocol

    init(viewModel: NoteDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Note"
        view.backgroundColor = .black

        setupUI()
        fillData()
    }

    // MARK: - Setup UI
    private func setupUI() {

        titleField = UITextField()

        titleField?.borderStyle = .roundedRect
        titleField?.translatesAutoresizingMaskIntoConstraints = false
        
        contentView = UITextView()
        
        contentView?.layer.borderWidth = 1
        contentView?.layer.borderColor = UIColor.gray.cgColor
        contentView?.layer.cornerRadius = 10
        contentView?.translatesAutoresizingMaskIntoConstraints = false

        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .orange
        saveButton.layer.cornerRadius = 10
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        guard let titleField = titleField else { return }
        guard let contentView = contentView else { return }

        view.addSubview(titleField)
        view.addSubview(contentView)
        view.addSubview(saveButton)


        //Constraints
        NSLayoutConstraint.activate([
            titleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleField.heightAnchor.constraint(equalToConstant: 44),

            contentView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 15),
            contentView.leadingAnchor.constraint(equalTo: titleField.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: titleField.trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 200),

            saveButton.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    // MARK: - Fill Existing Data
    private func fillData() {
        guard let titleField = titleField else { return }
        guard let contentView = contentView else { return }

        titleField.text = viewModel.titleText
        contentView.text = viewModel.contentText
    }

    // MARK: - Save Action
    @objc private func saveTapped() {

        viewModel.save(
            title: titleField?.text ?? "",
            content: contentView?.text ?? ""
        )

        navigationController?.popViewController(animated: true)
    }
}
