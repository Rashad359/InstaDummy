//
//  FeedModel.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/31/25.
//

import UIKit

nonisolated struct FeedModel: Decodable {
    let data: [FeedItem]
}

enum FeedItem: Decodable {
    case ad(AdPost)
    case normal(NormalPost)
    case threads(ThreadGroup)
    case peopleSuggestions(PeopleSuggestion)
    
    private enum CodingKeys: String, CodingKey {
        case postType
        case data
    }
    
    private enum PostType: String, Decodable {
        case ad
        case normal
        case threads
        case people_suggestion
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(PostType.self, forKey: .postType)
        
        switch type {
        case .ad:
            self = .ad(try container.decode(AdPost.self, forKey: .data))
        case .normal:
            self = .normal(try container.decode(NormalPost.self, forKey: .data))
        case .threads:
            self = .threads(try container.decode(ThreadGroup.self, forKey: .data))
        case .people_suggestion:
            self = .peopleSuggestions(try container.decode(PeopleSuggestion.self, forKey: .data))
        }
    }
}

struct AdPost: Decodable {
    let id: String
    let advertiserName: String
    let advertiserPhoto: String
    let image: String
    let shoppingUrl: String
    let likeCount: Int
    let likedBy: [String]
    let description: String
    let createdAt: String
}

struct NormalPost: Decodable {
    let id: String
    let username: String
    let userPhoto: String
    let location: String?
    let images: [String]
    let likeCount: Int
    let likedBy: [String]
    let description: String?
    let createdAt: String
}


struct ThreadGroup: Decodable {
    let id: String
    let threadTitle: String
    let joinCount: Int
    let posts: [ThreadPost]
}

struct ThreadPost: Decodable {
    let id: String
    let ownerPhoto: String
    let username: String
    let createdAt: String
    let image: String?
    let text: String?
    let likeCount: Int
    let commentCount: Int
    let repostCount: Int
    let sharedCount: Int
}


struct PeopleSuggestion: Decodable {
    let suggestions: [SuggestionItem]
}

struct SuggestionItem: Decodable {
    let photo: String
    let fullName: String
    let username: String
}
