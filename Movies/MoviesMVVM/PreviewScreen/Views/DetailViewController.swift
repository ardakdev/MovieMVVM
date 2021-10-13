// DetailViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// PreviewViewController
final class DetailViewController: UIViewController {
    // MARK: - Internal property

    var movieID = 0
    var backgroundColor: UIColor = {
        UIColor.black
    }()

    var detailViewModel: DetailViewModelProtocol? {
        didSet {
            detailViewModel?.updateDetails = { [weak self] featchData in
                self?.movieDescription = featchData.movieDetails
                DispatchQueue.main.async {
                    self?.detailTableView.reloadData()
                }
            }
        }
    }

    // MARK: - private properties

    private let detailTableView = UITableView()
    private let posterID = "PosterTableViewCell"
    private let titleID = "TitleTableViewCell"
    private let overviewID = "OverviewTableViewCell"
    private var movieDescription: Movie?

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewcontroller()
    }

    // MARK: - private methods

    private func createDetailTableView() {
        detailTableView.separatorStyle = .none
        detailTableView.translatesAutoresizingMaskIntoConstraints = false
        detailTableView.backgroundColor = .clear
        detailTableView.dataSource = self
        detailTableView.delegate = self
        detailTableView.estimatedRowHeight = 500.0
        detailTableView.rowHeight = UITableView.automaticDimension
        view.addSubview(detailTableView)
    }

    private func registerCellDetailTableView() {
        detailTableView.register(PosterTableViewCell.self, forCellReuseIdentifier: posterID)
        detailTableView.register(TitleTableViewCell.self, forCellReuseIdentifier: titleID)
        detailTableView.register(OverviewTableViewCell.self, forCellReuseIdentifier: overviewID)
    }

    private func setConstraintsDetailTableView() {
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            detailTableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            detailTableView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20),
            detailTableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            detailTableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }

    private func setupViewcontroller() {
        view.backgroundColor = backgroundColor
        detailViewModel?.loadMovieDetails(movieID: movieID)
        createDetailTableView()
        registerCellDetailTableView()
        setConstraintsDetailTableView()
    }

    private func getPosterCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> PosterTableViewCell {
        guard let moveiDesc = movieDescription else { return PosterTableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: posterID, for: indexPath)
            as? PosterTableViewCell else { return PosterTableViewCell() }
        cell.imageAPIService = ImageAPIService()
        guard let posterPath = moveiDesc.posterPath else { return PosterTableViewCell() }
        cell.setImage(Constants.imageCatalog + posterPath)
        return cell
    }

    private func getTitleCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> TitleTableViewCell {
        guard let moveiDesc = movieDescription else { return TitleTableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: titleID, for: indexPath)
            as? TitleTableViewCell else { return TitleTableViewCell() }
        guard let title = moveiDesc.title else { return TitleTableViewCell() }
        cell.setTitle(title)
        return cell
    }

    private func getOverviewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> OverviewTableViewCell {
        guard let moveiDesc = movieDescription else { return OverviewTableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: overviewID, for: indexPath)
            as? OverviewTableViewCell else { return OverviewTableViewCell() }
        guard let overview = moveiDesc.overview else { return OverviewTableViewCell() }
        cell.setOverview(overview)
        return cell
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return getPosterCell(tableView, cellForRowAt: indexPath)
        case 1:
            return getTitleCell(tableView, cellForRowAt: indexPath)
        case 2:
            return getOverviewCell(tableView, cellForRowAt: indexPath)
        default:
            return UITableViewCell()
        }
    }
}
