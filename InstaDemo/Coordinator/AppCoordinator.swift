//
//  AppCoordinator.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 10/28/25.
//

import UIKit

protocol Coordinator {
    func start()
}

protocol StoriesCoordinatorProtocol {
    func showNextStory(after currentStory: StoryModel)
    func showPreviousStory(before currentStory: StoryModel)
    func closeStories()
}

class AppCoordinator: Coordinator, StoriesCoordinatorProtocol {
    
    private var stories: [StoryModel] = []
    private var currentIndex: Int = 0
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainVC = MainViewBuilder(coordinator: self).build()
        navigationController.setViewControllers([mainVC], animated: true)
    }
    
    func navigateToStories(stories: [StoryModel], startFrom story: StoryModel) {
        self.stories = stories
        guard let index = stories.firstIndex(of: story) else { return }
        currentIndex = index
        
        showStory(at: currentIndex)
    }
    
    func showNextStory(after currentStory: StoryModel) {
        guard let index = stories.firstIndex(of: currentStory) else { return }
        let nextIndex = index + 1
        
        if nextIndex < stories.count {
            currentIndex = nextIndex
            showStory(at: currentIndex, direction: .fromRight)
        } else {
            closeStories()
        }
    }
    
    func showPreviousStory(before currentStory: StoryModel) {
        guard let index = stories.firstIndex(of: currentStory) else { return }
        let prevIndex = index - 1
        
        if prevIndex >= 0 {
            currentIndex = prevIndex
            showStory(at: currentIndex, direction: .fromLeft)
        } else {
            closeStories()
        }
    }
    
    func closeStories() {
        navigationController.popToRootViewController(animated: true)
    }
    
    private func showStory(at index: Int, direction: CATransitionSubtype = .fromRight) {
        guard index < stories.count else {
            closeStories()
            return
        }
        
        let story = stories[index]
        let storiesVC = StoriesBuilder(coordinator: self).build(with: story)
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = direction
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        navigationController.view.layer.add(transition, forKey: kCATransition)
        navigationController.pushViewController(storiesVC, animated: false)
    }
}
