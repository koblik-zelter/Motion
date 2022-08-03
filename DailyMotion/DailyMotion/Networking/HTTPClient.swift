//
//  HTTPClient.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 02.08.2022.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

protocol HTTPClientProtocol {
    func makeRequest(_ request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

class HTTPClient: HTTPClientProtocol {

    private let urlSession: URLSession

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    func makeRequest(_ request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        urlSession.dataTask(with: request, completionHandler: completion).resume()
    }

}
