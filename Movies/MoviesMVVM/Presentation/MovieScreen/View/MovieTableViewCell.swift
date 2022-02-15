// MovieTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// MovieTableViewCell используется для вывода списка фильмов
final class MovieTableViewCell: UITableViewCell {
    // MARK: - private properties

    var imageAPIService: ImageAPIServiceProtocol?
    private let posterImageView: UIImageView = {
        let posterImageView = UIImageView()
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleAspectFit
        return posterImageView
    }()

    private let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .random()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Title"
        title.font = .boldSystemFont(ofSize: 16)
        title.textAlignment = .center
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private let descriptionLabel: UILabel = {
        let description = UILabel()
        description.text = "description"
        description.numberOfLines = 8
        description.lineBreakMode = .byWordWrapping
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()

    private let releaseDateLabel: UILabel = {
        let releaseDateLabel = UILabel()
        releaseDateLabel.text = "date"
        releaseDateLabel.font = .boldSystemFont(ofSize: 16)
        releaseDateLabel.textAlignment = .right
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        return releaseDateLabel
    }()

    private let voteAverageLabel: UILabel = {
        let voteAverageLabel = UILabel()
        voteAverageLabel.text = "8.8"
        voteAverageLabel.font = .boldSystemFont(ofSize: 24)
        voteAverageLabel.layer.borderWidth = 2
        voteAverageLabel.layer.borderColor = UIColor.yellow.cgColor
        voteAverageLabel.layer.cornerRadius = 4
        voteAverageLabel.layer.masksToBounds = true
        voteAverageLabel.backgroundColor = .gray
        voteAverageLabel.textAlignment = .center
        voteAverageLabel.translatesAutoresizingMaskIntoConstraints = false
        return voteAverageLabel
    }()

    // MARK: - Initializer

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addingSubViews()
        setCellBachgroundViewCorner()
        setCellBackgroundViewAnchor()
        setPosterImageViewAnchor()
        setTitleLabelAnchor()
        setDescriptionLabelAnchor()
        setReleaseDateLabelAnchor()
        setVoteAverageLabelAnchor()
    }

    // MARK: - Internal methods

    func configureCell(movie: Movie) {
        imageAPIService?.fetchPosterData(posterPath: movie.posterPath, completionHandler: { [weak self] result in
            switch result {
            case let .success(data):
                self?.setPosterImage(image: UIImage(data: data))
            default:
                break
            }
        })
        setTitle(title: movie.title)
        setDescription(description: movie.overview)
        setReleaseDate(releaseDate: movie.releaseDate)
        setVoteAverage(voteAverage: movie.voteAverage)
    }

    func setTitle(title: String?) {
        guard let title = title else { return }
        titleLabel.text = title
    }

    func setDescription(description: String?) {
        guard let description = description else { return }
        descriptionLabel.text = description
    }

    func setReleaseDate(releaseDate: String?) {
        guard let releaseDate = releaseDate else { return }
        releaseDateLabel.text = releaseDate
    }

    func setVoteAverage(voteAverage: Double?) {
        guard let voteAverage = voteAverage else { return }
        voteAverageLabel.text = "\(voteAverage)"
    }

    func setPosterImage(image: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            self?.posterImageView.image = image
        }
    }

    func getBackgroundViewColor() -> UIColor {
        guard let backgroundColor = cellBackgroundView.backgroundColor else { return .clear }
        return backgroundColor
    }

    // MARK: - Private methods

    private func addingSubViews() {
        posterImageView.addSubview(voteAverageLabel)
        cellBackgroundView.addSubview(posterImageView)
        cellBackgroundView.addSubview(titleLabel)
        cellBackgroundView.addSubview(descriptionLabel)
        cellBackgroundView.addSubview(releaseDateLabel)
        addSubview(cellBackgroundView)
    }

    private func setCellBackgroundViewAnchor() {
        NSLayoutConstraint.activate([
            cellBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            cellBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            cellBackgroundView.heightAnchor.constraint(greaterThanOrEqualToConstant: 180)
        ])
    }

    private func setPosterImageViewAnchor() {
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 5),
            posterImageView.centerYAnchor.constraint(equalTo: cellBackgroundView.centerYAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 170),
            posterImageView.widthAnchor.constraint(equalToConstant: 120),
        ])
    }

    private func setTitleLabelAnchor() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor)
        ])
    }

    private func setDescriptionLabelAnchor() {
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 5),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor),
        ])
    }

    private func setReleaseDateLabelAnchor() {
        NSLayoutConstraint.activate([
            releaseDateLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 5),
            releaseDateLabel.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: 5),
            releaseDateLabel.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor),
            releaseDateLabel.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -10),
        ])
    }

    private func setVoteAverageLabelAnchor() {
        NSLayoutConstraint.activate([
            voteAverageLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -5),
            voteAverageLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -5),
            voteAverageLabel.widthAnchor.constraint(equalToConstant: 45)
        ])
    }

    private func setCellBachgroundViewCorner() {
        cellBackgroundView.layer.cornerRadius = 10
        cellBackgroundView.layer.masksToBounds = true
        posterImageView.layer.cornerRadius = 10
        posterImageView.layer.masksToBounds = true
    }
}
