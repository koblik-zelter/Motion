//
//  VideoListPresenterTests.swift
//  DailyMotionTests
//
//  Created by Alexandr COBLIC-ZELTER on 03.08.2022.
//

import XCTest
@testable import DailyMotion

class VideoListPresenterTests: XCTestCase {

    let service = VideoListServiceMock()
    let imageLoader = ImageLoaderMock()
    let view = VideoListViewMock()

    lazy var sut = VideoListPresenter(service: service, imageLoader: imageLoader)

    func testFetchVideoListOnViewDidLoad() {
        service.fetchVideoListPromise = expectation(description: "Should fetch video list")
        service.fetchVideoListResult = .success([Video.stub()])

        sut.viewDidLoad(view)
        waitForExpectations(timeout: 1)

        XCTAssertEqual(view.reloadDataCallCount, 1)
        XCTAssertEqual(view.showLoadingCallCount, 2) // startLoading, stopLoading
    }

    func testReportsErrorFromVideoListService() {
        service.fetchVideoListPromise = expectation(description: "Should fetch video list")
        service.fetchVideoListResult = .failure(VideoListError.badURL)

        sut.viewDidLoad(view)
        waitForExpectations(timeout: 1)

        XCTAssertEqual(view.reloadDataCallCount, 0)
        XCTAssertEqual(view.showErrorCallCount, 1)
        XCTAssertEqual(view.showLoadingCallCount, 2) // startLoading, stopLoading
    }

    func testReportsLoadedImage() {
        sut.viewDidLoad(view)

        let expectedImage = UIImage()
        imageLoader.getImageResult = .success(expectedImage)

        sut.getImage(for: "url") { image, urlString in
            XCTAssertEqual(image, expectedImage)
        }
    }
}
