//
//  PhotoFeedError.swift
//  MyPracticeApp
//
//  Created by Sachin Srivastava on 09/03/23.
//

enum PhotoFeedError: Error {
    
    case unknown
    
    case invalidUrl
    
    case networkError
    
    case invalidImageUrl
    
    case invalidThumbnailUrl
    
    case imageFetchFailed
    
    case thumbnailFetchFailed
}
