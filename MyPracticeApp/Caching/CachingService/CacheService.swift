//
//  CacheService.swift
//  MyPracticeApp
//
//  Created by Sachin Srivastava on 08/03/23.
//

import Combine
import Foundation
import SwiftUI

protocol CacheService {
    
    func getImage(url: String) -> AnyPublisher<UIImage?, CacheError>
}

struct CacheServiceImp: CacheService {
    
    private let imageCache: ImageCache
    private let networkService: NetworkService
//    private let telemetryService: TelemetryService
//    private let loggingService: LoggingService
//    private let experimentationService: ExperimentationService
        
    init(imageCache: ImageCache = ImageCacheImp(),
         networkService: NetworkService = NetworkServiceImp()) {
        self.imageCache = imageCache
        self.networkService = networkService
    }
    
    func getImage(url: String) -> AnyPublisher<UIImage?, CacheError> {
        if let data = ImageCacheImp.getImage(url: url) {
            return Just(UIImage(data: data)).setFailureType(to: CacheError.self).eraseToAnyPublisher()
        }
        
        // handle case for `fetch already in progress`
        
        // fetch from network
        ImageCacheImp.addToInProgressItems(url)
        
        return networkService.fetch(url: url)
            .mapError { _ in CacheError.invalidUrl }
            .map { imageData in
                ImageCacheImp.removeFromInProgressItems(url)
                ImageCacheImp.cacheImage(url: url, data: imageData)
                
                return UIImage(data: imageData)
            }
            .eraseToAnyPublisher()
    }
}
