// PosterTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// PosterTableViewCell вывод счейки с постером на DetailViewController
final class PosterTableViewCell: UITableViewCell {
    // MARK: - internal property

    var imageAPIService: ImageAPIServiceProtocol?

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
        imageAPIService?.featchPosterData(posterPath: imagePath, completionHandler: { [weak self] result in
            switch result {
            case let .success(data):
                DispatchQueue.main.async {
                    self?.posterImageView.image = UIImage(data: data)
                }
            default:
                break
            }
        })
    }
}
