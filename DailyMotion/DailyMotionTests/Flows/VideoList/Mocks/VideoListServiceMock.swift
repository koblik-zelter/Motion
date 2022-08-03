//
//  VideoListServiceMock.swift
//  DailyMotionTests
//
//  Created by Alexandr COBLIC-ZELTER on 03.08.2022.
//

import XCTest
@testable import DailyMotion

final class VideoListServiceMock: VideoListServiceProtocol {

    var fetchVideoListResult: Result<[Video], Error>?
    var fetchVideoListPromise: XCTestExpectation?
    func fetchVideoList(completion: @escaping (Result<[Video], Error>) -> Void) {
        if let fetchVideoListResult = fetchVideoListResult {
            completion(fetchVideoListResult)
        }
        fetchVideoListPromise?.fulfill()
    }
}
