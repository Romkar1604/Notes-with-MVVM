//
//  NotesListViewController.swift
//  ReminderMVVM
//
//  Created by Omkar Ranawade on 2/19/26.
//

import UIKit

final class NotesListViewController: UIViewController {

    // MARK: - Properties
    var tableView: UITableView?
    private var viewModel: NotesListViewModelProtocol = NotesListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Notes"
        view.backgroundColor = .orange
        
        // Add button
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNoteTapped)
        )
        setupTable()
        bindViewModel()
    }

    // MARK: - Setup TableView
    private func setupTable() {
        
        tableView = UITableView()
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        tableView?.backgroundColor = .black
        tableView?.separatorColor = .orange
        tableView?.dataSource = self
        tableView?.delegate = self

        tableView?.register(NoteTableViewCell.self, forCellReuseIdentifier: "NoteCell")
        
        guard let tableView = tableView else { return }
        view.addSubview(tableView)

        //Constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - ViewModel
    private func bindViewModel() {
        viewModel.onNotesChanged = { [weak self] in
            guard let tableView = self?.tableView else { return }
            tableView.reloadData()
        }
    }

    // MARK: - Actions
    @objc private func addNoteTapped() {
        let addVC = AddNoteViewController(listViewModel: viewModel)
        navigationController?.pushViewController(addVC, animated: true)
    }
}

// MARK: - DataSource
extension NotesListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell",for: indexPath) as! NoteTableViewCell

        let note = viewModel.note(at: indexPath.row)
        cell.configure(with: note)

        return cell
    }
}

// MARK: - Delegate
extension NotesListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        let note = viewModel.note(at: indexPath.row)
        let detailVM = NoteDetailViewModel(note: note, listViewModel: viewModel)
        let detailVC = NoteDetailViewController(viewModel: detailVM)

        navigationController?.pushViewController(detailVC, animated: true)
    }
}
