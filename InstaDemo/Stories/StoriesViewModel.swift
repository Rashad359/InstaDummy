//
//  StoriesViewModel.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 11/3/25.
//

import UIKit

final class StoriesViewModel {
    
    private var story: StoryModel
    var storyModel: StoryModel { story }
    
    private let coordinator: AppCoordinator
    
    init(story: StoryModel, coordinator: AppCoordinator) {
        self.story = story
        self.coordinator = coordinator
    }
    
    func showNextStories() {
        coordinator.showNextStory(after: story)
    }
    
    func showPreviousStories() {
        coordinator.showPreviousStory(before: story)
    }
    
    func closeStories() {
        coordinator.closeStories()
    }
}
