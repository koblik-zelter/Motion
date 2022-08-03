//
//  Video.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 03.08.2022.
//

import Foundation

struct Video: Codable, Equatable {
    let id: String
    let thumbnailURL: String
    let title: String
    let description: String
    let url: String
    let createdTime: Double

    enum CodingKeys: String, CodingKey {
        case id, title, description, url
        case thumbnailURL = "thumbnail_1080_url"
        case createdTime = "created_time"
    }
}

extension Video {
    var formattedCreatedDate: String {
        DateFormatter.localizedString(from: Date(timeIntervalSince1970: createdTime), dateStyle: .long, timeStyle: .short)
    }
}
