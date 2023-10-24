// MovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class MovieViewController: UIViewController {
    // MARK: - private properties

    private let movieCaterogies = [Constants.popular, Constants.topRates, Constants.topComing]
    private var movies: MoviesPage?

    // MARK: - internal properties

    var viewModel: MainViewModelProtocol?

    // MARK: - Initializer

    override func viewDidLoad() {
        view = MovieView()
        setupViewController()
    }

    // MARK: - private methods

    private func view() -> MovieView {
        guard let view = self.view as? MovieView else { return MovieView() }
        return view
    }

    private func setupViewController() {
        view().movieTableView.delegate = self
        view().movieTableView.dataSource = self
        viewModel?.loadMoviesList(
            urlString: Constants.topComing,
            category: view().topicSegmentControl.selectedSegmentIndex
        )
        view().topicSegmentControl.selectedSegmentIndex = 0
        view().topicSegmentControl.addTarget(self, action: #selector(segmentChange), for: .valueChanged)
        binding()
    }

    private func binding() {
        viewModel?.movies.bind { [weak self] movies in
            self?.movies = movies
            DispatchQueue.main.async {
                self?.view().movieTableView.reloadData()
            }
        }
    }

    @objc private func segmentChange() {
        viewModel?.loadMoviesList(
            urlString: movieCaterogies[view().topicSegmentControl.selectedSegmentIndex],
            category: view().topicSegmentControl.selectedSegmentIndex
        )
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
        cell.imageAPIService = ImageAPIService()
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
        guard let movieID = movies?.results[indexPath.row].id else { return }
        viewModel?.tapOnMovie(movieID: movieID)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
