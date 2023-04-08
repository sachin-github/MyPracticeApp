//
//  DependencyResolver.swift
//  MyPracticeApp
//
//  Created by Sachin Srivastava on 08/03/23.
//

import Foundation

final class DependencyResolver {
    
    static func makeNetworkService() -> NetworkService {
        return NetworkServiceImp()
    }
    
    static func makeImageCache() -> ImageCache {
        return ImageCacheImp()
    }
    
    static func makeCacheService() -> CacheService {
        return CacheServiceImp(imageCache: makeImageCache(),
                               networkService: makeNetworkService())
    }
}
