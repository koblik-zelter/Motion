//
//  VideoListViewControllerTests.swift
//  DailyMotionTests
//
//  Created by Alexandr COBLIC-ZELTER on 03.08.2022.
//

import XCTest
@testable import DailyMotion

class VideoListViewControllerTests: XCTestCase {

    let presenter = VideoListPresenterMock()

    lazy var sut = VideoListViewController(presenter: presenter, delegate: self, dispatcher: DispatchQueueMock())

    var videoListViewControllerDidSelectVideoCallCount = 0

    func testDisplayVideoList() {
        presenter.videos = [.stub(), .stub(), .stub()]
        sut.loadViewIfNeeded()
        guard let tableView = sut.view.firstSubview(withAccessibilityIdentifier: "tableView") as? UITableView else {
            XCTFail("tableView should be presented")
            return
        }

        XCTAssertEqual(tableView.numberOfRows(inSection: 0), presenter.videos.count)
        XCTAssertEqual(presenter.viewDidLoadCallCount, 1)
    }

    func testShowLoadingIndicatorOnLoading() {
        sut.loadViewIfNeeded()
        sut.showLoading(true)
        guard let activityIndicator = sut.view.firstSubview(withAccessibilityIdentifier: "activityIndicator") as? UIActivityIndicatorView else {
            XCTFail("activityIndicator should be presented")
            return
        }

        XCTAssertFalse(activityIndicator.isHidden)
    }

    func testHideLoadingIndicatorOnStopLoading() {
        sut.loadViewIfNeeded()
        sut.showLoading(false)
        guard let activityIndicator = sut.view.firstSubview(withAccessibilityIdentifier: "activityIndicator") as? UIActivityIndicatorView else {
            XCTFail("activityIndicator should be presented")
            return
        }

        XCTAssertTrue(activityIndicator.isHidden)
    }

    func testDisplayAlertWhenErrorOccured() {
        let window = UIWindow()
        window.rootViewController = sut
        window.makeKeyAndVisible()

        sut.loadViewIfNeeded()
        sut.showError()

        waitAlerPresentation(on: sut)
    }

    
    private func waitAlerPresentation(on viewController: UIViewController) {
        let animationFinishedPredicate = NSPredicate { vc, _ in
            guard let vc = vc as? UIViewController else {
                return false
            }

            guard vc.presentedViewController is UIAlertController else {
                return false
            }

            return true
        }
        let animationFinishedExpectation = self.expectation(for: animationFinishedPredicate, evaluatedWith: viewController, handler: nil)
        self.wait(for: [animationFinishedExpectation], timeout: 10)
    }

}

extension VideoListViewControllerTests: VideoListViewControllerDelegate {

    func videoListViewControllerDidSelectVideo(_ sender: UIViewController, title: String, urlString: String) {
        videoListViewControllerDidSelectVideoCallCount += 1
    }

}
