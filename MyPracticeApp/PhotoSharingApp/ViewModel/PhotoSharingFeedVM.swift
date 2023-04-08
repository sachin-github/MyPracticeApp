//
//  PhotoSharingFeed.swift
//  MyPracticeApp
//
//  Created by Sachin Srivastava on 10/03/23.
//

import Combine
import Foundation

protocol PhotoSharingFeedViewModel {
    
    func generateNextFeed()
}

class PhotoSharingFeedViewModelImpl: ObservableObject {
    
    @Published
    var feedViewData: [FeedData] = []
    
    private let feedService: PhotoFeedService
    private var cancelBag = Set<AnyCancellable>()
    
    init(feedService: PhotoFeedService = PhotoSharingDependencyResolver.makePhotoFeedService()) {
        self.feedService = feedService
    }
    
    
}

extension PhotoSharingFeedViewModelImpl: PhotoSharingFeedViewModel {
    
    func generateNextFeed() {
        
        feedService.fetchFeed()
            .receive(on: DispatchQueue.main)
            .sink{ feed in
                guard let feed = feed else { return }
                self.feedViewData.append(contentsOf: feed)
//                self.objectWillChange.send()
//                print("Received values: \(String(describing: self.feedViewData))")
            }
            .store(in: &cancelBag)
    }
}
