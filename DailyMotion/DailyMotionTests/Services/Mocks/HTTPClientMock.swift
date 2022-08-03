//
//  HTTPClientMock.swift
//  DailyMotionTests
//
//  Created by Alexandr COBLIC-ZELTER on 03.08.2022.
//

import XCTest
@testable import DailyMotion

final class HTTPClientMock: HTTPClientProtocol {

    var makeRequestPromise: XCTestExpectation?
    var makeRequestResult: (Data?, URLResponse?, Error?)?
    func makeRequest(_ request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let makeRequestResult = makeRequestResult {
            completion(makeRequestResult.0, makeRequestResult.1, makeRequestResult.2)
        }
        makeRequestPromise?.fulfill()
    }

}
