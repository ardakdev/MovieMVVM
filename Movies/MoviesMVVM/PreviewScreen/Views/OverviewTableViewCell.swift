// OverviewTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class OverviewTableViewCell: UITableViewCell {
    // MARK: - private property

    private let overviewLabel = UILabel()

    // MARK: - Initializer

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupContentView()
        createOverviewLabel()
        setConstraintsOverviewLabel()
    }

    // MARK: - Private methods

    private func setupContentView() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    private func createOverviewLabel() {
        overviewLabel.font = .systemFont(ofSize: 20)
        overviewLabel.numberOfLines = 0
        overviewLabel.textAlignment = .left
        overviewLabel.lineBreakMode = .byWordWrapping
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(overviewLabel)
    }

    private func setConstraintsOverviewLabel() {
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: topAnchor, constant: -15),
            overviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            overviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Internal method

    func setOverview(_ overview: String) {
        overviewLabel.text = overview
    }
}
