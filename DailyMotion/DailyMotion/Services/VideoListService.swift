//
//  VideoListService.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 02.08.2022.
//

import Foundation

protocol VideoListServiceProtocol {
    func fetchVideoList(completion: @escaping (Result<[Video], Error>) -> Void)
}

enum VideoListError: Error {
    case badURL
    case networking(Error?)
    case decoding
}

enum URLQueryItemKey: String {
    case channel
    case limit
    case fields
}

enum FieldTypes: String, CaseIterable {
    case id
    case thumbnail = "thumbnail_1080_url"
    case title
    case description
    case url
    case createdTime = "created_time"
}

final class VideoListService: VideoListServiceProtocol {

    private static let pageSize = 20

    private var lastResponse: VideoListResponse?

    private let httpClient: HTTPClientProtocol
    private let appConfig: AppConfig
    private let jsonDecoder: JSONDecoder

    init(httpClient: HTTPClientProtocol,
         appConfig: AppConfig,
         jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.httpClient = httpClient
        self.appConfig = appConfig
        self.jsonDecoder = jsonDecoder
    }

    func fetchVideoList(completion: @escaping (Result<[Video], Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = appConfig.environment.endpoint
        urlComponents.path = "/videos"
        urlComponents.queryItems = [URLQueryItem(name: URLQueryItemKey.channel.rawValue, value: "news"),
                                    URLQueryItem(name: URLQueryItemKey.limit.rawValue, value: "\(Self.pageSize)"),
                                    URLQueryItem(name: URLQueryItemKey.fields.rawValue, value: FieldTypes.allCases.map { $0.rawValue }.joined(separator: ","))]

        guard let url = urlComponents.url else {
            completion(.failure(VideoListError.badURL))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethods.get.rawValue

        httpClient.makeRequest(urlRequest) { [weak self] data, response, error in
            guard let self = self else {
                return
            }

            if let error = error {
                completion(.failure(VideoListError.networking(error)))
                return
            }

            guard let response = response as? HTTPURLResponse,
                  200..<300 ~= response.statusCode,
                  let data = data else {
                completion(.failure(VideoListError.networking(nil)))
                return
            }

            do {
                let response = try self.jsonDecoder.decode(VideoListResponse.self, from: data)
                self.lastResponse = response
                completion(.success(response.list))
            } catch {
                completion(.failure(VideoListError.decoding))
            }

        }
    }
    
}
