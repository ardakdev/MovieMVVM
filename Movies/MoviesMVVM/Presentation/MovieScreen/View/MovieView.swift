// MovieView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class MovieView: UIView {
    let topicSegmentControl = UISegmentedControl(items: ["Popular", "Top Rated", "Up Comming"])
    let movieTableView = UITableView()
    let segmentHeight: CGFloat = 30
    let estimatedRowHeight: CGFloat = 170

    // MARK: - Private methods

    override func layoutSubviews() {
        setupView()
    }

    private func createTopicSegmentControl() {
        topicSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(topicSegmentControl)
    }

    private func createMovieTableView() {
        movieTableView.translatesAutoresizingMaskIntoConstraints = false
        movieTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        movieTableView.rowHeight = UITableView.automaticDimension
        movieTableView.estimatedRowHeight = estimatedRowHeight
        addSubview(movieTableView)
    }

    private func setAnchorTopicSegmentControl() {
        let margins = layoutMarginsGuide
        NSLayoutConstraint.activate([
            topicSegmentControl.bottomAnchor
                .constraint(equalTo: margins.bottomAnchor),
            topicSegmentControl.leadingAnchor
                .constraint(equalTo: margins.leadingAnchor),
            topicSegmentControl.trailingAnchor
                .constraint(equalTo: margins.trailingAnchor),
            topicSegmentControl.heightAnchor.constraint(equalToConstant: segmentHeight)
        ])
    }

    private func setAnchorMovieTableView() {
        let margins = layoutMarginsGuide
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

    private func setupView() {
        createTopicSegmentControl()
        createMovieTableView()
        setAnchorTopicSegmentControl()
        setAnchorMovieTableView()
    }
}
