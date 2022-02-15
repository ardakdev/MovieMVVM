// DetailViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// PreviewViewController
final class DetailViewController: UIViewController {
    // MARK: - Internal property

    var movieID = 0
    var backgroundColor: UIColor = {
        UIColor.gray
    }()

    var viewModel: DetailViewModelProtocol?

    // MARK: - private properties

    private let tableView = UITableView()
    private let posterID = "PosterTableViewCell"
    private let titleID = "TitleTableViewCell"
    private let overviewID = "OverviewTableViewCell"
    var movieDescription: Movie?

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }

    // MARK: - private methods

    private func createDetailTableView() {
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 500.0
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
    }

    private func registerCellDetailTableView() {
        tableView.register(PosterTableViewCell.self, forCellReuseIdentifier: posterID)
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: titleID)
        tableView.register(OverviewTableViewCell.self, forCellReuseIdentifier: overviewID)
    }

    private func setConstraintsDetailTableView() {
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }

    private func binding() {
        viewModel?.movieDetails.bind { [weak self] movie in
            self?.movieDescription = movie
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func setupViewController() {
        view.backgroundColor = backgroundColor
        createDetailTableView()
        registerCellDetailTableView()
        setConstraintsDetailTableView()
        binding()
    }

    private func getPosterCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> PosterTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: posterID, for: indexPath)
            as? PosterTableViewCell else { return PosterTableViewCell() }
        cell.imageAPIService = ImageAPIService()
        guard let imageData = movieDescription?.posterData else { return PosterTableViewCell() }
        cell.setImageFromData(imageData: imageData)
        return cell
    }

    private func getTitleCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> TitleTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: titleID, for: indexPath)
            as? TitleTableViewCell else { return TitleTableViewCell() }
        guard let title = movieDescription?.title else { return TitleTableViewCell() }
        cell.setTitle(title)
        return cell
    }

    private func getOverviewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> OverviewTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: overviewID, for: indexPath)
            as? OverviewTableViewCell else { return OverviewTableViewCell() }
        guard let overview = movieDescription?.overview else { return OverviewTableViewCell() }
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
