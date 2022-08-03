//
//  VideoListPresenterMock.swift
//  DailyMotionTests
//
//  Created by Alexandr COBLIC-ZELTER on 03.08.2022.
//

import UIKit
@testable import DailyMotion

final class VideoListPresenterMock: VideoListPresenterProtocol {

    var videos: [Video] = []

    var viewDidLoadCallCount = 0
    func viewDidLoad(_ view: VideoListViewProtocol) {
        viewDidLoadCallCount += 1
        view.reloadData()
    }

    var fetchVideoListCallCount = 0
    func fetchVideoList() {
        fetchVideoListCallCount += 1
    }

    var getImageCallCount = 0
    func getImage(for urlString: String, completion: @escaping (UIImage, String) -> Void) {
        getImageCallCount += 1
    }

}

