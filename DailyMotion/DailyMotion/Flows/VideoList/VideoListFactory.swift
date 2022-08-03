//
//  VideoListFactory.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 02.08.2022.
//

import UIKit

protocol VideoListFactoryProtocol {
    func makeVideoListViewController(delegate: VideoListViewControllerDelegate) -> UIViewController
    func makeVideoViewController(title: String, url: URL) -> UIViewController
}

final class VideoListFactory: VideoListFactoryProtocol {

    private let context: Context

    init(context: Context) {
        self.context = context
    }

    func makeVideoListViewController(delegate: VideoListViewControllerDelegate) -> UIViewController {
        let presenter = VideoListPresenter(service: context.videoListService, imageLoader: context.imageLoader)
        return VideoListViewController(presenter: presenter, delegate: delegate)
    }

    func makeVideoViewController(title: String, url: URL) -> UIViewController {
        WebViewController(title: title, url: url)
    }
}
