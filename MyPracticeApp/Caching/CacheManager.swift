//
//  CacheManager.swift
//  MyPracticeApp
//
//  Created by Sachin Srivastava on 08/03/23.
//

import Combine
import Foundation
import SwiftUI

/// Errors for fetching image
public enum CacheError: Error {
    
    case unknown
    
    case invalidUrl
}

/// Public protocol to help consumers to fetch image from the cache
public protocol CacheManager {
    
    /// Function to perform fetch operation for the requested image url
    /// - Parameter url: image url
    /// - Returns: Publisher of Swift UI's `UIImage` if image is found, `CacheError` otherwise.
    func getImage(url: String) -> AnyPublisher<UIImage?, CacheError>
}

public final class CacheManagerImp: CacheManager {
    
    private let cacheService: CacheService
    
    init() {
        self.cacheService = DependencyResolver.makeCacheService()
    }
    
    public func getImage(url: String) -> AnyPublisher<UIImage?, CacheError> {
        cacheService.getImage(url: url)
    }
}
