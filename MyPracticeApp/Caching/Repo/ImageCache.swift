//
//  ImageCache.swift
//  MyPracticeApp
//
//  Created by Sachin Srivastava on 08/03/23.
//

import Combine
import Foundation

private struct Constants {
    static let maxCacheSize = 5
}

struct CacheData {
    let data: Data
    let created: Date
    var lastUsed: Date
}

protocol ImageCache {
    
    static func getImage(url: String) -> Data?
    
    static func cacheImage(url: String, data: Data)
    
    static func isInProgressItem(_ url: String) -> Bool
    
    static func addToInProgressItems(_ url: String)
    
    static func removeFromInProgressItems(_ url: String)
}

class ImageCacheImp: ImageCache {
    
    private static var cache: [String: CacheData] = [:]
    private static var inProgressItems = Set<String>()
    
    static func getImage(url: String) -> Data? {
        guard var cachedData = cache[url] else {
            return nil
        }
        
        cachedData.lastUsed = Date()
        cache[url] = cachedData
        return cachedData.data
    }
    
    static func cacheImage(url: String, data: Data) {
        let cachedData = CacheData(data: data, created: Date(), lastUsed: Date())
        
        if cache.isSafeLimit() {
            cache[url] = cachedData
        } else {
            // handle case for cache cleanup using LRU
        }
    }
    
    static func isInProgressItem(_ url: String) -> Bool {
        return inProgressItems.contains(url)
    }
    
    static func addToInProgressItems(_ url: String) {
        inProgressItems.insert(url)
    }
    
    static func removeFromInProgressItems(_ url: String) {
        inProgressItems.remove(url)
    }
}

private extension Dictionary {
    
    func isSafeLimit() -> Bool {
        return self.count < Constants.maxCacheSize
    }
}
