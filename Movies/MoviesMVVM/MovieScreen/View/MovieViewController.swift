// MovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class MovieViewController: UIViewController {
    // MARK: - private properties

    private let movieCaterogies = [Constants.popular, Constants.topRates, Constants.topComing]
    private var movies: MoviesPage?
    private let movieView = MovieView()

    var viewModel: MVVMViewModel? {
        didSet {
            viewModel?.updateViewData = { [weak self] featchData in
                self?.movies = featchData?.movies
                DispatchQueue.main.async {
                    self?.movieView.movieTableView.reloadData()
                }
            }
        }
    }

    // MARK: - Initializer

    override func viewDidLoad() {
        setupViewController()
    }

    // MARK: - private methods

    private func setupViewController() {
        movieView.topicSegmentControl.addTarget(self, action: #selector(segmentChange), for: .valueChanged)
        movieView.movieTableView.delegate = self
        movieView.movieTableView.dataSource = self
        movieView.topicSegmentControl.selectedSegmentIndex = 0
        movieView.frame = view.frame
        view.addSubview(movieView)
        viewModel?.startFetch(urlString: Constants.topComing)
    }

    @objc private func segmentChange() {
        viewModel?.startFetch(urlString: movieCaterogies[movieView.topicSegmentControl.selectedSegmentIndex])
    }
}

// MARK: - UITableViewDataSource

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies?.results.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell
        else { return UITableViewCell() }
        guard let movie = movies?.results[indexPath.row] else { return UITableViewCell() }
        cell.configureCell(movie: movie)
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0

        UIView.animate(withDuration: 0.75) {
            cell.alpha = 1
        }
    }
}

// MARK: - UITableViewDelegate

extension MovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = movies?.results[indexPath.row] else { return }
        guard let movieID = movie.id else { return }
        guard let cell = tableView.cellForRow(at: indexPath) as? MovieTableViewCell else { return }
        let previewVC = DetailViewController()
        previewVC.movieID = movieID
        previewVC.backgroundColor = cell.getBackgroundViewColor()
        navigationController?.pushViewController(previewVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
