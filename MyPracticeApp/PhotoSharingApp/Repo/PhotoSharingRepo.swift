//
//  PhotoSharingRepo.swift
//  MyPracticeApp
//
//  Created by Sachin Srivastava on 10/03/23.
//

import Combine
import SwiftUI

// MARK: Protocol

protocol PhotoSharingRepo {
    
    func fetchFeed() -> AnyPublisher<[FeedData]?, PhotoFeedError>
    
    func fetchImage(_ url: String) -> AnyPublisher<UIImage?, PhotoFeedError>
    
    func fetchThumbnail(_ url: String) -> AnyPublisher<UIImage?, PhotoFeedError>
}

// MARK: Implementation

class PhotoSharingRepoImpl: PhotoSharingRepo {
    
    private let networkService: PhotoSharingNetworkClient
    
    private var lastFetchedAlbumIdForFeed = 0
    
    init(networkService: PhotoSharingNetworkClient = PhotoSharingDependencyResolver.makeNetworkService()) {
        self.networkService = networkService
    }
    
    func fetchFeed() -> AnyPublisher<[FeedData]?, PhotoFeedError> {
        lastFetchedAlbumIdForFeed += 1
        print("Fetching new album: \(lastFetchedAlbumIdForFeed)")
        return networkService.fetchFeed(id: lastFetchedAlbumIdForFeed)
    }
    
    func fetchImage(_ url: String) -> AnyPublisher<UIImage?, PhotoFeedError> {
        return networkService.fetchImageData(url)
            .map { imageData in
                guard let imageData = imageData,
                      let image = UIImage(data: imageData) else {
                    return nil
                }
                
                return image
            }
            .mapError { _ in PhotoFeedError.imageFetchFailed }
            .eraseToAnyPublisher()
    }
    
    func fetchThumbnail(_ url: String) -> AnyPublisher<UIImage?, PhotoFeedError> {
        return networkService.fetchImageData(url)
            .map { imageData in
                guard let imageData = imageData,
                      let image = UIImage(data: imageData) else {
                    return nil
                }
                
                return image
            }
            .mapError { _ in PhotoFeedError.imageFetchFailed }
            .eraseToAnyPublisher()
    }
}
