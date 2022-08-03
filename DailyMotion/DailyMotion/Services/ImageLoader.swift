//
//  ImageLoader.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 02.08.2022.
//

import Foundation
import UIKit

protocol ImageLoaderProtocol {
    func getImage(for urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}

final class ImageLoader: ImageLoaderProtocol {
    enum ImageLoaderError: Error {
        case badURL
        case networking(Error?)
    }

    private let httpClient: HTTPClientProtocol
    private let cache: CacheProtocol
    private let workQueue = DispatchQueue(label: "com.ackz.imageLoader", qos: .userInitiated)
    private var inProgressItems: [String] = []

    init(httpClient: HTTPClientProtocol, cache: CacheProtocol = Cache()) {
        self.httpClient = httpClient
        self.cache = cache
    }

    func getImage(for urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(ImageLoaderError.badURL))
            return
        }

        workQueue.async { [self] in
            if let data = cache.getData(from: url),
               let image = UIImage(data: data) {
                completion(.success(image))
                return
            }

            let request = URLRequest(url: url)
            httpClient.makeRequest(request) { [weak self] data, response, error in
                guard let self = self else {
                    return
                }

                if let error = error {
                    completion(.failure(ImageLoaderError.networking(error)))
                    return
                }

                guard let response = response as? HTTPURLResponse,
                      200..<300 ~= response.statusCode else {
                    completion(.failure(ImageLoaderError.networking(nil)))
                    return
                }

                if let data = data,
                   let image = UIImage(data: data) {
                    self.cache.writeData(data, to: url)
                    completion(.success(image))
                }
            }
        }
    }
}
