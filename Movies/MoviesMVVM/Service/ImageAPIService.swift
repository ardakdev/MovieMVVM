// ImageAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftUI

protocol ImageAPIServiceProtocol {
    func featchPosterData(posterPath: String?, completionHandler: @escaping (Result<Data, Error>) -> ())
}

final class ImageAPIService: ImageAPIServiceProtocol {
    func featchPosterData(posterPath: String?, completionHandler: @escaping (Result<Data, Error>) -> ()) {
        if let loadedData = loadPictureFromDirectory(fileName: posterPath ?? "") {
            completionHandler(.success(loadedData))
        } else {
            let path = "\(Constants.imageCatalog)\(posterPath ?? "")"
            guard let url = URL(string: path) else { return }

            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                if error != nil {
                    guard let error = error else { return }
                    completionHandler(.failure(error))
                    return
                }
                guard let data = data else { return }
                self?.savePictureToDirectory(data: data, fileName: posterPath ?? "")
                completionHandler(.success(data))
            }.resume()
        }
    }

    func loadPictureFromDirectory(fileName: String) -> Data? {
        guard let dataPath = FileManager.default.urls(for: .picturesDirectory, in: .userDomainMask).first?
            .appendingPathComponent(fileName.replacingOccurrences(of: "/", with: ""))
        else { return nil }

        guard let loadedData = try? Data(contentsOf: dataPath) else { return nil }

        return loadedData
    }

    func savePictureToDirectory(data: Data, fileName: String) {
        guard let dataPath = FileManager.default.urls(for: .picturesDirectory, in: .userDomainMask).first
        else { return }
        if !FileManager.default.fileExists(atPath: dataPath.path) {
            do {
                try FileManager.default.createDirectory(
                    atPath: dataPath.path,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
            } catch {
                print(error.localizedDescription)
            }
        }

        guard let path = FileManager.default.urls(for: .picturesDirectory, in: .userDomainMask).first?
            .appendingPathComponent(fileName.replacingOccurrences(of: "/", with: "")) else { return }
        do {
            try data.write(to: path)
        } catch {
            print(error.localizedDescription)
        }
    }
}
