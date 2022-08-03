//
//  Context.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 02.08.2022.
//

import Foundation

// DI Tool
struct Context {
    let appConfig: AppConfig
    let httpClient: HTTPClientProtocol
    let videoListService: VideoListServiceProtocol
    let imageLoader: ImageLoaderProtocol

    init() {
        self.appConfig = AppConfig(environment: .live)
        self.httpClient = HTTPClient(urlSession: .shared)
        self.videoListService = VideoListService(httpClient: httpClient, appConfig: appConfig)
        self.imageLoader = ImageLoader(httpClient: HTTPClient(urlSession: URLSession(configuration: .ephemeral)))
    }
}
