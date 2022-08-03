//
//  Video + Stub.swift
//  DailyMotionTests
//
//  Created by Alexandr COBLIC-ZELTER on 03.08.2022.
//

import Foundation
@testable import DailyMotion

extension Video {
    static func stub(id: String = UUID().uuidString,
                     thumbnailURL: String = "",
                     title: String = "",
                     description: String = "",
                     url: String = "",
                     createdTime: Double = 0) -> Video {
        Video(id: id, thumbnailURL: thumbnailURL, title: title, description: description, url: url, createdTime: createdTime)
    }
}
