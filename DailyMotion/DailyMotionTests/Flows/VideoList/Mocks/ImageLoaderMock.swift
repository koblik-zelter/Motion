//
//  ImageLoaderMock.swift
//  DailyMotionTests
//
//  Created by Alexandr COBLIC-ZELTER on 03.08.2022.
//

import XCTest
@testable import DailyMotion

final class ImageLoaderMock: ImageLoaderProtocol {

    var getImageResult: Result<UIImage, Error>?
    var getImagePromise: XCTestExpectation?
    func getImage(for urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let getImageResult = getImageResult {
            completion(getImageResult)
        }
        getImagePromise?.fulfill()
    }

}
