//
//  FeedData.swift
//  MyPracticeApp
//
//  Created by Sachin Srivastava on 09/03/23.
//

struct FeedData: Codable, Hashable, Equatable {
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
    
    static func ==(lhs: FeedData, rhs: FeedData) -> Bool {
        return lhs.id == rhs.id
    }
}
