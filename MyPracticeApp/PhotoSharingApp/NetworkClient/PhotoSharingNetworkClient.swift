//
//  PhotoSharingNetworkClient.swift
//  MyPracticeApp
//
//  Created by Sachin Srivastava on 09/03/23.
//

import Combine
import Foundation

// MARK: Protocol

protocol PhotoSharingNetworkClient {
    
    func fetchFeed(id: Int) -> AnyPublisher<[FeedData]?, PhotoFeedError>
    
    func fetchImageData(_ url: String) -> AnyPublisher<Data?, PhotoFeedError>
}

// MARK: Implementation

struct PhotoSharingNetworkClientImpl: PhotoSharingNetworkClient {
    
    func fetchFeed(id: Int) -> AnyPublisher<[FeedData]?, PhotoFeedError> {
        guard let fetchUrl = URL(string: Constants.feedUrl) else {
            return Fail(error: PhotoFeedError.invalidUrl).eraseToAnyPublisher()
        }
        
        NetworkCallRecorder.newCallRequest()
        
        return URLSession.shared.dataTaskPublisher(for: fetchUrl)
            .first()
            .map { networkResponse in
                let jsonDecoder = JSONDecoder()
                let networkData = networkResponse.data
                var feedData: [FeedData] = []
                
                do {
                    feedData = try jsonDecoder.decode([FeedData].self, from: networkData)
                } catch {}
                
                feedData = feedData.filter { $0.albumId == id }
                
                return feedData
            }
            .mapError { _ in PhotoFeedError.networkError }
            .eraseToAnyPublisher()
    }
    
    func fetchImageData(_ url: String) -> AnyPublisher<Data?, PhotoFeedError> {
        guard let fetchUrl = URL(string: url) else {
            return Fail(error: PhotoFeedError.invalidImageUrl).eraseToAnyPublisher()
        }
        
        NetworkCallRecorder.newCallRequest()
        
        return URLSession.shared.dataTaskPublisher(for: fetchUrl)
            .map { $0.data }
            .mapError { _ in PhotoFeedError.imageFetchFailed }
            .eraseToAnyPublisher()
    }
        
    private struct Constants {
        static let feedUrl = "https://jsonplaceholder.typicode.com/photos"
    }
}
