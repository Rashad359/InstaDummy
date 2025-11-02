//
//  MainViewModel.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/28/25.
//

import UIKit

protocol MainViewDelegate: AnyObject {
    func didFetchProfiles(_ item: [ProfilesCell.Item])
    func didFetchFeed(_ item: [PostsHandler])
    func error(_ error: Error)
}

final class MainViewModel {
    private let networkManager = DependencyContainer.shared.networkManager
    
    private weak var delegate: MainViewDelegate? = nil
    
    func subscribe(_ delegate: MainViewDelegate) {
        self.delegate = delegate
    }
    
    func fetchProfiles() {
        networkManager.fetchProfiles { result in
            switch result {
            case .success(let data):
                
                let cellData = self.mapDataToProfile(model: data)
                self.delegate?.didFetchProfiles(cellData)
                
            case .failure(let error):
                
                self.delegate?.error(error)
                
            }
        }
    }
    
    func fetchFeed() {
        networkManager.fetchFeed { result in
            switch result {
            case .success(let data):
                print("success")
                var newItems: [PostsHandler] = []
                
                data.data.forEach { item in
                    switch item {
                    case .normal(let normalPost):
                        
                        let normalPostData = self.mapDataToNormalItem(normalPost)
                        
                        newItems.append(.normalPost(normalPostData))
                        
                    case .ad(let adPost):
                        
                        let adPostData = self.mapDataToAdItem(adPost)
                        
                        newItems.append(.ads(adPostData))
                        
                    case .peopleSuggestions(let peopleSuggestions):
                        
                        let peopleSuggestionData = self.mapDataToPeopleSuggestionsItem(peopleSuggestions)
                        
                        newItems.append(.peopleSuggestions(peopleSuggestionData))
                        
                    case .threads(let threads):
                        
                        let threadsData = self.mapDataToThreadsItem(threads)
                        
                        newItems.append(.threads(threadsData))
                    }
                    
                    self.delegate?.didFetchFeed(newItems)
                }
                
                
            case .failure(let error):
                print("SOMETHING WENT WRONG: ", error.localizedDescription)
            }
        }
    }
    
    func mapDataToProfile(model: ProfileModel) -> [ProfilesCell.Item] {
        model.data.map { item in
            return .init(
                name: item.username,
                imageUrl: item.userPhoto,
                isLive: item.isLive
            )
        }
    }
    
    func mapDataToNormalItem(_ data: NormalPost) -> PostsCell.Item {
        return .init(username: data.username, userImage: data.userPhoto, location: data.location ?? "No location", postImage: self.mapDataToNormalImages(data), description: data.description ?? "hello world", likeCount: data.likeCount, likedBy: data.likedBy.first ?? "")
    }
    
    func mapDataToAdItem(_ data: AdPost) -> AdvertisementCell.Item {
        return .init(username: data.advertiserName, userImage: data.advertiserPhoto, description: data.description, postImage: data.image, likeCount: data.likeCount, likedBy: data.likedBy.first ?? "someone", date: data.createdAt, shoppingUrl: data.shoppingUrl)
    }
    
    func mapDataToThreadsItem(_ data: ThreadGroup) -> ThreadsCell.Item {
        let posts = data.posts.map { post in
            return ThreadPostCell.Item(
                profileImage: post.ownerPhoto,
                userName: post.username,
                postDescription: post.text ?? "",
                postImage: post.image ?? "",
                postDate: post.createdAt,
                likeCount: post.likeCount,
                commentCount: post.commentCount,
                repostCount: post.repostCount,
                sharedCount: post.sharedCount
            )
        }
        
        return .init(
            username: data.threadTitle,
            joinCount: data.joinCount,
            posts: posts
        )
    }
    
    func mapDataToPeopleSuggestionsItem(_ data: PeopleSuggestion) -> [PeopleAccountsCell.Item] {
        data.suggestions.map { item in
            return .init(
                profileImage: item.photo,
                profileName: item.fullName,
                shortName: item.username
            )
        }
    }
    
    func mapDataToNormalImages(_ data: NormalPost) -> [ImageCell.Item] {
        data.images.map { imageUrl in
            return .init(image: imageUrl)
        }
    }
}
