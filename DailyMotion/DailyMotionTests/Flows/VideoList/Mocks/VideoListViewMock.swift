//
//  VideoListViewMock.swift
//  DailyMotionTests
//
//  Created by Alexandr COBLIC-ZELTER on 03.08.2022.
//

import Foundation
@testable import DailyMotion

final class VideoListViewMock: VideoListViewProtocol {

    var showLoadingCallCount = 0
    func showLoading(_ isLoading: Bool) {
        showLoadingCallCount += 1
    }

    var reloadDataCallCount = 0
    func reloadData() {
        reloadDataCallCount += 1
    }

    var showErrorCallCount = 0
    func showError() {
        showErrorCallCount += 1
    }

}
