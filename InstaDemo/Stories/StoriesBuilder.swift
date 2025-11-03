//
//  StoriesBuilder.swift
//  InstaDemo
//
//  Created by Rəşad Əliyev on 11/3/25.
//

import UIKit

final class StoriesBuilder {
    
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func build(with story: StoryModel) -> UIViewController {
        let viewModel = StoriesViewModel(story: story, coordinator: coordinator)
        let storiesVC = StoriesViewController(viewModel: viewModel)
        return storiesVC
    }
}
