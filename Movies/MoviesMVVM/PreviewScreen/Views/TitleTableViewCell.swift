// TitleTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class TitleTableViewCell: UITableViewCell {
    // MARK: - private property

    private let titleLabel = UILabel()

    // MARK: - Initializer

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        createTitleLabel()
        setupContentView()
        setConstraintsTitleLabel()
    }

    // MARK: - private methods

    private func createTitleLabel() {
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
    }

    private func setupContentView() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    private func setConstraintsTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    // MARK: - internal method

    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
