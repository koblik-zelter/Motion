//
//  APIEnvironment.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 03.08.2022.
//

import Foundation

enum APIEnvironment {
    case live

    var endpoint: String {
        switch self {
        case .live:
            return "api.dailymotion.com"
        }
    }
}
