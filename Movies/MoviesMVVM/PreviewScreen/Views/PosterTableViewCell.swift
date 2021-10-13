// PosterTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// PosterTableViewCell вывод счейки с постером на DetailViewController
final class PosterTableViewCell: UITableViewCell {
    // MARK: - private property

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()

    // MARK: - Initializer

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupContentView()
        createPosterImageView()
        setConstrainPostarImageView()
    }

    // MARK: - private methods

    private func setConstrainPostarImageView() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            posterImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            posterImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 0.65)
        ])
    }

    private func createPosterImageView() {
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(posterImageView)
    }

    private func setupContentView() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    // MARK: - intertal method

    func setImage(_ imagePath: String) {
        guard let url = URL(string: imagePath) else { return }
        guard let imageData = try? Data(contentsOf: url) else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.posterImageView.image = UIImage(data: imageData)
        }
    }
}
