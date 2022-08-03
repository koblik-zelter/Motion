//
//  Cache.swift
//  DailyMotion
//
//  Created by Alexandr COBLIC-ZELTER on 03.08.2022.
//

import Foundation

protocol CacheProtocol {
    func writeData(_ data: Data, to url: URL)
    func getData(from url: URL) -> Data?
}

final class Cache: CacheProtocol {

    private let cacheDirectoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first

    func writeData(_ data: Data, to url: URL) {
        guard let cacheURL = generateRelativeURL(url: url) else {
            assertionFailure("Cannot create cacheURL")
            return
        }

        try? data.write(to: cacheURL)
    }

    func getData(from url: URL) -> Data? {
        guard let cacheURL = generateRelativeURL(url: url) else {
            assertionFailure("Cannot create cacheURL")
            return nil
        }

        return try? Data(contentsOf: cacheURL)
    }

    private func generateRelativeURL(url: URL) -> URL? {
        let hostComponents = (url.host ?? "").components(separatedBy: ".").reversed()
        let pathComponents = url.relativePath.components(separatedBy: "/")
        let filename = (hostComponents + pathComponents)
            .filter { !$0.isEmpty }
            .joined(separator: "_")
        return cacheDirectoryURL?.appendingPathComponent(filename, isDirectory: false)
    }
}
