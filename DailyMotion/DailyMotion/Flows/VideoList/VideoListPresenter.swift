//
//  VideoListPresenter.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 02.08.2022.
//

import Foundation
import UIKit

protocol VideoListPresenterProtocol {
    var videos: [Video] { get }

    func viewDidLoad(_ view: VideoListViewProtocol)
    func fetchVideoList()
    func getImage(for urlString: String, completion: @escaping(UIImage, String) -> Void)
}

final class VideoListPresenter: VideoListPresenterProtocol {

    private(set) var videos: [Video] = [] {
        didSet {
            view?.reloadData()
        }
    }

    private weak var view: VideoListViewProtocol?
    private let service: VideoListServiceProtocol
    private let imageLoader: ImageLoaderProtocol

    init(service: VideoListServiceProtocol, imageLoader: ImageLoaderProtocol) {
        self.service = service
        self.imageLoader = imageLoader
    }

    func viewDidLoad(_ view: VideoListViewProtocol) {
        self.view = view
        fetchVideoList()
    }

    func fetchVideoList() {
        view?.showLoading(true)
        service.fetchVideoList { [weak self] result in
            self?.view?.showLoading(false)
            switch result {
            case .success(let videos):
                self?.videos = videos
            case .failure:
                self?.view?.showError()
            }
        }
    }

    func getImage(for urlString: String, completion: @escaping (UIImage, String) -> Void) {
        imageLoader.getImage(for: urlString) { result in
            switch result {
            case .success(let image):
                completion(image, urlString)
            default:
                break
            }
        }
    }

}
