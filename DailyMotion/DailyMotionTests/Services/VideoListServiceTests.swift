//
//  VideoListServiceTests.swift
//  DailyMotionTests
//
//  Created by Alexandr COBLIC-ZELTER on 03.08.2022.
//

import XCTest
@testable import DailyMotion

class VideoListServiceTests: XCTestCase {

    let httpClient = HTTPClientMock()
    lazy var sut = VideoListService(httpClient: httpClient, appConfig: AppConfig(environment: .live))

    func testReportsArrayOfVideoOnFetch() {
        httpClient.makeRequestPromise = expectation(description: "should make request")

        let videoListResponse = VideoListResponse(page: 1, limit: 20, total: 100, hasMore: true, list: [.stub(id: "0")])
        let expectedData = try? JSONEncoder().encode(videoListResponse)

        let response = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        httpClient.makeRequestResult = (expectedData, response, nil)

        var fetchResult: Result<[Video], Error>?

        sut.fetchVideoList { result in
            fetchResult = result
        }

        waitForExpectations(timeout: 1)
        
        switch fetchResult {
        case .success(let videos):
            XCTAssertEqual(videos, [.stub(id: "0")])
        case .failure, .none:
            XCTFail("Should report array of videos")
        }
    }

    func testReportsDecodingError() {
        httpClient.makeRequestPromise = expectation(description: "should make request")
        let wrongData = "testString".data(using: .utf8)
        let response = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        httpClient.makeRequestResult = (wrongData, response, nil)

        var fetchResult: Result<[Video], Error>?

        sut.fetchVideoList { result in
            fetchResult = result
        }

        waitForExpectations(timeout: 1)
        
        switch fetchResult {
        case .success, .none:
            XCTFail("Should report error")
        case .failure(let err):
            XCTAssertEqual(err.localizedDescription, VideoListError.decoding.localizedDescription)
        }
    }

    func testReportsNetworkError() {
        httpClient.makeRequestPromise = expectation(description: "should make request")
        httpClient.makeRequestResult = (nil, nil, VideoListError.networking(nil))

        var fetchResult: Result<[Video], Error>?

        sut.fetchVideoList { result in
            fetchResult = result
        }

        waitForExpectations(timeout: 1)
        
        switch fetchResult {
        case .success, .none:
            XCTFail("Should report error")
        case .failure(let err):
            XCTAssertEqual(err.localizedDescription, VideoListError.networking(nil).localizedDescription)
        }
    }

    func testReporstNetworkErrorWhenStatusCodeIsNotInInterval() {
        httpClient.makeRequestPromise = expectation(description: "should make request")
        let response = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        httpClient.makeRequestResult = (nil, response, nil)

        var fetchResult: Result<[Video], Error>?

        sut.fetchVideoList { result in
            fetchResult = result
        }

        waitForExpectations(timeout: 1)
        
        switch fetchResult {
        case .success, .none:
            XCTFail("Should report error")
        case .failure(let err):
            XCTAssertEqual(err.localizedDescription, VideoListError.networking(nil).localizedDescription)
        }
    }
}
