//
//  StoriesViewModel.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 11/3/25.
//

import UIKit

protocol StoriesViewDelegate: AnyObject {
    func didShowProgress(_ time: Float)
}

final class StoriesViewModel {
    
    private var timer: Timer?
    
    private var elapsedTime: TimeInterval = 0
    
    private var progress: Float {
        Float(elapsedTime / 5)
    }
    
    private var story: StoryModel
    var storyModel: StoryModel { story }
    
    private let coordinator: AppCoordinator
    
    init(story: StoryModel, coordinator: AppCoordinator) {
        self.story = story
        self.coordinator = coordinator
    }
    
    private weak var delegate: StoriesViewDelegate? = nil
    
    func subscribe(_ delegate: StoriesViewDelegate) {
        self.delegate = delegate
    }
    
    func showNextStories() {
        coordinator.showNextStory(after: story)
    }
    
    func showPreviousStories() {
        coordinator.showPreviousStory(before: story)
    }
    
    private func closeStories() {
        coordinator.closeStories()
    }
    
    func startProgress() {
        stopProgress()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { _ in
            self.elapsedTime += 0.05
            self.delegate?.didShowProgress(self.progress)
            
            if self.elapsedTime >= 5 {
                self.stopProgress()
                self.showNextStories()
                
            }
        })
    }
    
    func stopProgress() {
        timer?.invalidate()
        timer = nil
    }
}
