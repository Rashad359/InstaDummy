//
//  MainViewModel.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/28/25.
//

import UIKit
import Combine

final class MainViewModel {
    
    @Published private(set) var profileItems: [ProfilesCell.Item] = []
    
    @Published private(set) var items: [PostsHandler] = []
    
    @Published private(set) var error: Error? = nil
    
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    private let networkManager = DependencyContainer.shared.networkManager
    
    func insertYourStory() {
        profileItems.insert(.init(name: "Your Story", imageUrl: "https://i.pravatar.cc/100?img=12", postUrl: "https://fastly.picsum.photos/id/619/720/1280.jpg?hmac=v9BPzSXNfQWdOA_dZWLJaMomh8Vh6lwa8KRADnuF32o", isLive: false), at: 0)
    }
    
    func fetchProfiles() {
        networkManager.fetchProfiles { result in
            switch result {
            case .success(let data):
                
                var cellData = self.mapDataToProfile(model: data)
                
                if !cellData.contains(where: { $0.name == "Your Story"} ) {
                    cellData.insert(.init(name: "Your Story", imageUrl: "https://i.pravatar.cc/100?img=12", postUrl: "https://fastly.picsum.photos/id/619/720/1280.jpg?hmac=v9BPzSXNfQWdOA_dZWLJaMomh8Vh6lwa8KRADnuF32o", isLive: false), at: 0)
                }
                
                self.profileItems = cellData
                
            case .failure(let error):
                
                self.error = error
                
            }
        }
    }
    
    func fetchFeed() {
        networkManager.fetchFeed { result in
            switch result {
            case .success(let data):
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
                    
                    self.items = newItems
                    
                }
                
                
            case .failure(let error):
                
                self.error = error
            }
        }
    }
    
    func mapDataToProfile(model: ProfileModel) -> [ProfilesCell.Item] {
        model.data.map { item in
            return .init(
                name: item.username,
                imageUrl: item.userPhoto,
                postUrl: item.storyUrl,
                isLive: item.isLive
            )
        }
    }
    
    func mapDataToNormalItem(_ data: NormalPost) -> PostsCell.Item {
        return .init(
            username: data.username,
            userImage: data.userPhoto,
            location: data.location ?? "No location",
            postImage: self.mapDataToNormalImages(data),
            description: data.description ?? "hello world",
            likeCount: data.likeCount,
            likedBy: data.likedBy.first ?? "",
            createdAt: data.createdAt
        )
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
    
    func goToStories(with story: StoryModel, from profiles: [ProfilesCell.Item]) {
        let allStories = profiles.map { item in
            return StoryModel(
                profileImage: item.imageUrl,
                username: item.name,
                createdAt: "4h",
                postImage: item.postUrl,
                isSeen: item.isSeen
            )
        }
        
        coordinator.navigateToStories(stories: allStories, startFrom: story)
    }
    
    func markStoriesAsSeen(_ updatedStories: [StoryModel]) {
        for updatedStory in updatedStories {
            if let index = profileItems.firstIndex(where: { $0.name == updatedStory.username} ) {
                profileItems[index].isSeen = updatedStory.isSeen
            }
        }
        
        self.profileItems = profileItems
    }
    
    func markStorySeen(_ item: ProfilesCell.Item, at index: Int) {
        profileItems[index] = item
    }
}
