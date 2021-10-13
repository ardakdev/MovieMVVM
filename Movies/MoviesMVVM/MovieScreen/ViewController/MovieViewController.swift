// MovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// LibraryViewController
final class MovieViewController: UIViewController {
    // MARK: - private properties

    private let topicSegmentControl = UISegmentedControl(items: ["Popular", "Top Rated", "Up Comming"])
    private let movieCaterogies = [Constants.popular, Constants.topRates, Constants.topComing]
    private var movies: MoviesPage?
    private let movieTableView = UITableView()

    // MARK: - Initializer

    override func viewDidLoad() {
        setupViewController()
    }

    // MARK: - Private methods

    private func createTopicSegmentControl() {
        topicSegmentControl.selectedSegmentIndex = 0
        topicSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        topicSegmentControl.addTarget(self, action: #selector(segmentChange), for: .valueChanged)
        view.addSubview(topicSegmentControl)
    }

    private func createMovieTableView() {
        movieTableView.translatesAutoresizingMaskIntoConstraints = false
        movieTableView.dataSource = self
        movieTableView.delegate = self
        movieTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        movieTableView.rowHeight = UITableView.automaticDimension
        movieTableView.estimatedRowHeight = 170.0
        view.addSubview(movieTableView)
    }

    private func setAnchorTopcSegmentControl() {
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            topicSegmentControl.bottomAnchor
                .constraint(equalTo: margins.bottomAnchor),
            topicSegmentControl.leadingAnchor
                .constraint(equalTo: margins.leadingAnchor),
            topicSegmentControl.trailingAnchor
                .constraint(equalTo: margins.trailingAnchor),
            topicSegmentControl.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setAnchorMovieTableView() {
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            movieTableView.topAnchor
                .constraint(equalTo: margins.topAnchor),
            movieTableView.leadingAnchor
                .constraint(equalTo: margins.leadingAnchor),
            movieTableView.trailingAnchor
                .constraint(equalTo: margins.trailingAnchor),
            movieTableView.bottomAnchor.constraint(equalTo: topicSegmentControl.topAnchor)
        ])
    }

    private func setupViewController() {
        title = "Movie"
        createTopicSegmentControl()
        createMovieTableView()
        fetchData()
        setAnchorTopcSegmentControl()
        setAnchorMovieTableView()
    }

    private func fetchData() {
        guard let url = URL(string: movieCaterogies[topicSegmentControl.selectedSegmentIndex]) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self else { return }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.movies = try decoder.decode(MoviesPage.self, from: data)
                DispatchQueue.main.async {
                    self.movieTableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }

    @objc private func segmentChange() {
        fetchData()
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
