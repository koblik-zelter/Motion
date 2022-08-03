//
//  VideoListResponse.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 02.08.2022.
//

import Foundation

struct VideoListResponse: Codable, Equatable {
    let page: Int
    let limit: Int
    let total: Int
    let hasMore: Bool
    let list: [Video]

    enum CodingKeys: String, CodingKey {
        case page, limit, total, list
        case hasMore = "has_more"
    }
}
