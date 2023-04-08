//
//  PhotoSharingDependencyResolver.swift
//  MyPracticeApp
//
//  Created by Sachin Srivastava on 10/03/23.
//

struct PhotoSharingDependencyResolver {
    
    static func makeNetworkService() -> PhotoSharingNetworkClient {
        return PhotoSharingNetworkClientImpl()
    }
    
    static func makeRepo() -> PhotoSharingRepo {
        return PhotoSharingRepoImpl()
    }
    
    static func makePhotoFeedService() -> PhotoFeedService {
        return PhotoFeedServiceImpl()
    }
}
