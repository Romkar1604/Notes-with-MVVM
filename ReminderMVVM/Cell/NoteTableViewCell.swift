//
//  NoteTableViewCell.swift
//  ReminderMVVM
//
//  Created by Omkar Ranawade on 2/19/26.
//

import UIKit

final class NoteTableViewCell: UITableViewCell {

    // MARK: - Properties
    var titleLabel: UILabel?
    var contentLabel: UILabel?

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override var backgroundColor: UIColor? {
        didSet {
            contentView.backgroundColor = .black
        }
    }
    
    // MARK: - Setup UI
    private func setupUI() {

        titleLabel = UILabel()
        titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel?.textColor = .white
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false

        contentLabel = UILabel()
        contentLabel?.font = .systemFont(ofSize: 14)
        contentLabel?.textColor = .white
        contentLabel?.numberOfLines = 2
        contentLabel?.translatesAutoresizingMaskIntoConstraints = false

        guard let titleLabel = titleLabel else { return }
        contentView.addSubview(titleLabel)
        
        guard let contentLabel = contentLabel else { return }
        contentView.addSubview(contentLabel)


        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            contentLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    // MARK: - Configure
    func configure(with note: Note) {

        titleLabel?.text = note.title
        contentLabel?.text = note.content
    }
}
